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
    final now = nowUtc().copyWith(
      hour: group.startHour,
      minute: group.startMinute,
      second: 0,
    );
    print('Current time is $now');
    final nextWeek = List.generate(8, (index) {
      return now.add(Duration(days: index));
    });
    print('Days considered for run are $nextWeek');
    const oneDay = Duration(days: 1);
    final nextRun = nextWeek.firstWhere((day) {
      // Run groups run at most once a day, so next run must be
      // 24 hours after the previous
      return day.isAfter(groupLastRunTime.add(oneDay)) && //
          programFrequency.contains(day.weekday);
    });
    print('Next run should occur at $nextRun');
    return nextRun;
  }
}
