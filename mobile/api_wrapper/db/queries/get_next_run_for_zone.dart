import 'package:collection/collection.dart';
import 'package:postgres/postgres.dart';

import '../models/db_customer.dart';
import '../models/db_program.dart';
import '../models/db_run.dart';
import '../models/db_run_group.dart';
import '../models/db_zone.dart';
import '../models/next_run_for_zone.dart';
import 'get_controller_by_id.dart';
import 'get_next_run_for_run_group.dart';
import 'get_run_groups_by_program_id.dart';
import 'get_runs_by_run_group_id.dart';

class GetNextRunForZone {
  GetNextRunForZone(
    PostgreSQLConnection Function() db,
  )   : _getControllerById = GetControllerById(db),
        _getRunsByRunGroupId = GetRunsByRunGroupId(db),
        _getNextRunForRunGroup = GetNextRunForRunGroup(db),
        _getRunGroupsByProgramId = GetRunGroupsByProgramId(db);

  final GetControllerById _getControllerById;
  final GetRunsByRunGroupId _getRunsByRunGroupId;
  final GetRunGroupsByProgramId _getRunGroupsByProgramId;
  final GetNextRunForRunGroup _getNextRunForRunGroup;

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
      final groupsToRuns = <DbRunGroup, List<DbRun>>{};
      final groupsToNextRunTime = <DbRunGroup, DateTime>{};
      final programRunGroups = await _getRunGroupsByProgramId(program.id);
      for (final runGroup in programRunGroups) {
        groupsToRuns[runGroup] = await _getRunsByRunGroupId(runGroup.id);
      }
      for (final runGroup in programRunGroups) {
        groupsToNextRunTime[runGroup] = await _getNextRunForRunGroup(group: runGroup);
      }

      final sortedRunGroups = List.of(groupsToRuns.keys)
        ..sort((a, b) {
          final nextRunA = groupsToNextRunTime[a]!;
          final nextRunB = groupsToNextRunTime[b]!;
          return nextRunA.millisecondsSinceEpoch.compareTo(nextRunB.millisecondsSinceEpoch);
        });
      final groupWithNextRun = sortedRunGroups.firstWhereOrNull((g) {
        return groupsToRuns[g]!.any((r) => r.zoneId == zoneId);
      });
      if (groupWithNextRun == null) {
        return null;
      }

      final nextRun = await _getNextRunForRunGroup(group: groupWithNextRun);

      final runs = groupsToRuns[groupWithNextRun]!;

      return NextRunForZone(
        run: runs.singleWhere((r) => r.zoneId == zone.id),
        time: nextRun,
        duration: Duration(
          seconds: groupWithNextRun.durationSeconds,
        ),
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
