import 'package:postgres/postgres.dart';
import 'package:timezone/standalone.dart' as tz;

import '../../bin/utils/_date_time.dart';
import '../models/db_run_group.dart';
import 'get_controller_by_id.dart';
import 'get_program_by_id.dart';

class GetNextRunForRunGroup {
  GetNextRunForRunGroup(this.db)
      : _getControllerById = GetControllerById(db),
        _getProgramById = GetProgramById(db);

  final PostgreSQLConnection Function() db;
  final GetControllerById _getControllerById;
  final GetProgramById _getProgramById;

  Future<DateTime> call({required DbRunGroup group}) async {
    // TODO(brandon): When suspension ability is added, start at the suspension
    // time rather than lastRunTime if suspended.
    // If the group has never run, consider last run time as epoch
    final groupLastRunTime = group.lastRunTime ?? epochUtc();
    final program = await _getProgramById(group.programId);
    final programFrequency = program.frequency;
    final controller = await _getControllerById(program.controllerId);
    final timezone = controller.timezone;
    final location = tz.getLocation(timezone);
    final adjustedTime = nowUtc()
        // TODO(brandon): I don't think this will work when task is created
        // in, say, EDT but the next run is during EST (or vice versa).
        // However, attempting to use timezones is difficult because when
        // copying a DateTime (to set hour/minute/second/etc.) the time
        // is incorrectly converted *back* to UTC
        .add(
          Duration(
            milliseconds: location.currentTimeZone.offset,
          ),
        )
        .copyWith(
          hour: group.startHour,
          minute: group.startMinute,
          second: 0,
          millisecond: 0,
          microsecond: 0,
        );
    final eligibleNextRunDays = List.generate(8, (index) {
      return adjustedTime.add(Duration(days: index));
    });
    const oneDay = Duration(days: 1);
    final nextRun = eligibleNextRunDays.firstWhere((day) {
      // Run groups run at most once a day, so next run must be
      // 24 hours after the previous
      return day.isAfter(groupLastRunTime.add(oneDay)) && //
          programFrequency.contains(day.weekday);
    });
    // TODO(brandon): See note above RE: timezones
    final nextRunUtc = nextRun.subtract(
      Duration(
        milliseconds: location.currentTimeZone.offset,
      ),
    );
    return nextRunUtc;
  }
}
