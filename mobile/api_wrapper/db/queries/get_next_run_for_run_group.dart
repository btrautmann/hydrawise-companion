import '../../bin/utils/_date_time.dart';
import '../models/db_program.dart';
import '../models/db_run_group.dart';

class GetNextRunForRunGroup {
  GetNextRunForRunGroup();

  DateTime call({
    required DbRunGroup group,
    required DbProgram program,
  }) {
    // TODO(brandon): When suspension ability is added, start at the suspension
    // time rather than lastRunTime if suspended.
    // If the group has never run, consider last run time as epoch
    final groupLastRunTime = group.lastRunTime ?? epochUtc();
    print('Group lastRunTime is $groupLastRunTime');
    final programFrequency = program.frequency;
    print('Program frequency is $programFrequency');
    final utc = nowUtc();
    // Seed time is the current time adjusted to adopt the hour
    // and minute of the group's intended run time
    final seedTime = DateTime(
      utc.year,
      utc.month,
      utc.day,
      group.startHour,
      group.startMinute,
    );
    print(
      'Seed time is $seedTime in timezone ${seedTime.timeZoneName} with offset ${seedTime.timeZoneOffset}',
    );
    final eligibleNextRunDays = List.generate(8, (index) {
      return seedTime.add(Duration(days: index));
    });
    print('Eligible days for next run are $eligibleNextRunDays');
    const oneDay = Duration(days: 1);
    final nextRun = eligibleNextRunDays.firstWhere((day) {
      // Run groups run at most once a day, so next run must be
      // 24 hours after the previous
      return day.isAfter(groupLastRunTime.add(oneDay)) && //
          programFrequency.contains(day.weekday);
    });
    final nextRunUtc = nextRun.toUtc();
    print('Next run should occur at $nextRunUtc');
    return nextRunUtc;
  }
}
