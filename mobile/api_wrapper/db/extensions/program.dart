import '../models/db_program.dart';
import '../models/db_run.dart';
import '../models/next_run_for_zone.dart';

extension ProgramX on DbProgram {
  NextRunForZone? nextRun(int zoneId) {
    final runsForZone = runs.where((r) => r.zoneId == zoneId);
    if (runsForZone.isEmpty) {
      // This zone isn't a part of any runs
      return null;
    }
    // Collect the next run time for each run of this zone
    final runsToNextRunTime = <DbRun, DateTime>{};
    for (final run in runsForZone) {
      final now = DateTime.now();
      var nextRun = DateTime(
        now.year,
        now.month,
        now.day,
        run.startHour,
        run.startMinute,
      );
      while (nextRun.isBefore(now) || !frequency.contains(nextRun.weekday)) {
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
}

extension ListProgramX on List<DbProgram> {
  NextRunForZone? nextRun(int zoneId) {
    final nextRunsForEachProgram = map((p) => p.nextRun(zoneId));
    if (nextRunsForEachProgram.isEmpty && nextRunsForEachProgram.every((element) => element == null)) {
      return null;
    }
    nextRunsForEachProgram
        .where((run) => run != null)
        .toList()
        .sort((a, b) => a!.time.millisecondsSinceEpoch.compareTo(b!.time.millisecondsSinceEpoch));
    return nextRunsForEachProgram.first;
  }
}
