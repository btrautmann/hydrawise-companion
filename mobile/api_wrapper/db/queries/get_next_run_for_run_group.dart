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
    print('Group lastRunTime is $groupLastRunTime');
    final programFrequency = program.frequency;
    print('Program frequency is $programFrequency');
    final controller = await _getControllerById(program.controllerId);
    final timezone = controller.timezone;
    print('Controller ${controller.id} is in timezone $timezone');
    final location = tz.getLocation(timezone);
    // Seed time is the current time adjusted to adopt the hour
    // and minute of the group's intended run time
    final localTime = tz.TZDateTime.from(
      nowUtc().copyWith(
        hour: group.startHour,
        minute: group.startMinute,
        second: 0,
        millisecond: 0,
        microsecond: 0,
      ),
      location,
    );
    print(
      'localTime is $localTime in timezone ${localTime.timeZoneName} with offset ${localTime.timeZoneOffset}',
    );
    print('localTime isUtc? ${localTime.isUtc}');
    final eligibleNextRunDays = List.generate(8, (index) {
      return localTime.add(Duration(days: index));
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
