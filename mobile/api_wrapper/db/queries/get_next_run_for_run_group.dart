import 'package:postgres/postgres.dart';
import 'package:timezone/standalone.dart' as tz;

import '../../bin/utils/_date_time.dart';
import '../models/db_program.dart';
import '../models/db_run_group.dart';
import 'get_controller_by_id.dart';

class GetNextRunForRunGroup {
  GetNextRunForRunGroup(this.db) : _getControllerById = GetControllerById(db);

  final PostgreSQLConnection Function() db;
  final GetControllerById _getControllerById;

  Future<DateTime> call({
    required DbRunGroup group,
    required DbProgram program,
  }) async {
    // TODO(brandon): When suspension ability is added, start at the suspension
    // time rather than lastRunTime if suspended.
    // If the group has never run, consider last run time as epoch
    final groupLastRunTime = group.lastRunTime ?? epochUtc();
    final programFrequency = program.frequency;
    final controller = await _getControllerById(program.controllerId);
    final timezone = controller.timezone;
    final location = tz.getLocation(timezone);
    // Get user local time to figure out next run time, then convert
    // that to UTC and return
    final localTime = nowUtc().add(Duration(milliseconds: location.currentTimeZone.offset)).copyWith(
          hour: group.startHour,
          minute: group.startMinute,
          second: 0,
          millisecond: 0,
          microsecond: 0,
        );
    print('localTime is $localTime with timezone ${localTime.timeZoneName}');

    final eligibleNextRunDays = List.generate(8, (index) {
      return localTime.add(Duration(days: index));
    });
    const oneDay = Duration(days: 1);
    final nextRun = eligibleNextRunDays.firstWhere((day) {
      // Run groups run at most once a day, so next run must be
      // 24 hours after the previous
      return day.isAfter(groupLastRunTime.add(oneDay)) && //
          programFrequency.contains(day.weekday);
    });
    final nextRunUtc = nextRun.subtract(Duration(milliseconds: location.currentTimeZone.offset));
    print('Next run should occur at $nextRunUtc');
    return nextRunUtc;
  }
}
