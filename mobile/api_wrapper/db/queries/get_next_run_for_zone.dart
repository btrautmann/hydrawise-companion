import 'package:collection/collection.dart';
import 'package:postgres/postgres.dart';
import 'package:timezone/timezone.dart';

import '../models/db_customer.dart';
import '../models/db_program.dart';
import '../models/db_run.dart';
import '../models/db_run_group.dart';
import '../models/db_zone.dart';
import '../models/next_run_for_zone.dart';
import 'get_controller_by_id.dart';
import 'get_run_groups_by_program_id.dart';
import 'get_runs_by_run_group_id.dart';

class GetNextRunForZone {
  GetNextRunForZone(
    PostgreSQLConnection Function() db,
  )   : _getControllerById = GetControllerById(db),
        _getRunsByRunGroupId = GetRunsByRunGroupId(db),
        _getRunGroupsByProgramId = GetRunGroupsByProgramId(db);

  final GetControllerById _getControllerById;
  final GetRunsByRunGroupId _getRunsByRunGroupId;
  final GetRunGroupsByProgramId _getRunGroupsByProgramId;

  Future<NextRunForZone?> call({
    required List<DbProgram> programs,
    required DbZone zone,
    required DbCustomer customer,
  }) async {
    Future<NextRunForZone?> nextRunInProgram({
      required DbProgram program,
      required int zoneId,
      required String timezone,
    }) async {
      final runsForGroup = <DbRunGroup, List<DbRun>>{};
      final programRunGroups = await _getRunGroupsByProgramId(program.id);
      for (final runGroup in programRunGroups) {
        runsForGroup[runGroup] = await _getRunsByRunGroupId(runGroup.id);
      }
      // For simplicity, use the RunGroup with the earliest lastRunTime
      final sortedRunGroups = List.of(runsForGroup.keys)..sort((a, b) => a.lastRunTime.compareTo(b.lastRunTime));
      final groupWithNextRun = sortedRunGroups.firstWhereOrNull((g) {
        return runsForGroup[g]!.any((r) => r.zoneId == zoneId);
      });
      if (groupWithNextRun == null) {
        return null;
      }

      final runs = runsForGroup[groupWithNextRun]!;

      final location = getLocation(timezone);
      // Collect the next run time for each run of this zone
      final runsToNextRunTime = <DbRun, DateTime>{};
      final now = TZDateTime.now(location);
      for (final run in runs) {
        var nextRun = DateTime(
          now.year,
          now.month,
          now.day,
          groupWithNextRun.startHour,
          groupWithNextRun.startMinute,
        );
        while (nextRun.isBefore(now) || !program.frequency.contains(nextRun.weekday)) {
          // Each run is for a given time of a day, so push back the next run
          // until it's after the current time and the day falls on a day within
          // this program's frequency
          nextRun = nextRun.add(const Duration(days: 1));
        }
        runsToNextRunTime[run] = nextRun;
      }

      // Find the soonest "next run" amongst all the runs for this zone
      final times = runsToNextRunTime.values.toList()
        ..sort((a, b) => a.millisecondsSinceEpoch.compareTo(b.millisecondsSinceEpoch));
      final nextTime = times.first;

      return NextRunForZone(
        run: runsToNextRunTime.keys.where((k) => runsToNextRunTime[k] == nextTime).first,
        duration: Duration(seconds: groupWithNextRun.durationSeconds),
        time: nextTime,
      );
    }

    Future<NextRunForZone?> nextRunInPrograms({
      required List<DbProgram> programs,
      required int zoneId,
      required String timezone,
    }) async {
      final nextRuns = <NextRunForZone>[];
      for (final program in programs) {
        final nextRun = await nextRunInProgram(
          program: program,
          zoneId: zoneId,
          timezone: timezone,
        );
        if (nextRun != null) {
          nextRuns.add(nextRun);
        }
      }
      if (nextRuns.isEmpty) {
        return null;
      }
      nextRuns.toList().sort((a, b) => a.time.millisecondsSinceEpoch.compareTo(b.time.millisecondsSinceEpoch));
      return nextRuns.first;
    }

    final controller = await _getControllerById(customer.activeControllerId);
    final timezone = controller.timezone;
    return nextRunInPrograms(
      programs: programs,
      zoneId: zone.id,
      timezone: timezone,
    );
  }
}
