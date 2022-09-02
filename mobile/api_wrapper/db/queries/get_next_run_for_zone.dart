import 'package:postgres/postgres.dart';
import 'package:timezone/timezone.dart';

import '../models/db_customer.dart';
import '../models/db_program.dart';
import '../models/db_run.dart';
import '../models/db_zone.dart';
import '../models/next_run_for_zone.dart';
import 'get_controller_by_id.dart';

class GetNextRunForZone {
  GetNextRunForZone(this.connection) : _getControllerById = GetControllerById(connection);

  final Future<PostgreSQLConnection> Function() connection;
  final GetControllerById _getControllerById;

  Future<NextRunForZone?> call({
    required List<DbProgram> programs,
    required DbZone zone,
    required DbCustomer customer,
  }) async {
    NextRunForZone? nextRunInProgram({
      required DbProgram program,
      required int zoneId,
      required String timezone,
    }) {
      final runsForZone = program.runs.where((r) => r.zoneId == zoneId);
      if (runsForZone.isEmpty) {
        // This zone isn't a part of any runs
        return null;
      }
      final location = getLocation(timezone);
      // Collect the next run time for each run of this zone
      final runsToNextRunTime = <DbRun, DateTime>{};
      for (final run in runsForZone) {
        final now = TZDateTime.now(location);
        print('Time in $location is $now');
        var nextRun = DateTime(
          now.year,
          now.month,
          now.day,
          run.startHour,
          run.startMinute,
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
        run: runsToNextRunTime.keys.singleWhere((k) => runsToNextRunTime[k] == nextTime),
        time: nextTime,
      );
    }

    NextRunForZone? nextRunInPrograms({
      required List<DbProgram> programs,
      required int zoneId,
      required String timezone,
    }) {
      final nextRunsForEachProgram = programs.map(
        (p) => nextRunInProgram(
          program: p,
          zoneId: zoneId,
          timezone: timezone,
        ),
      );
      if (nextRunsForEachProgram.isEmpty && nextRunsForEachProgram.every((element) => element == null)) {
        return null;
      }
      nextRunsForEachProgram
          .where((run) => run != null)
          .toList()
          .sort((a, b) => a!.time.millisecondsSinceEpoch.compareTo(b!.time.millisecondsSinceEpoch));
      return nextRunsForEachProgram.first;
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
