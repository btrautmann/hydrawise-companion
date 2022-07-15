import 'package:api_models/api_models.dart';
import 'package:clock/clock.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:irri/programs/models/run_group.dart';

extension ListProgramX on List<Program> {
  /// Returns the runs that will run today,
  /// if any
  List<Run> todayRuns() {
    final now = clock.now();
    final dayOfWeek = now.weekday;
    final todayPrograms =
        where((element) => element.frequency.contains(dayOfWeek));
    return todayPrograms
        .expand(
          (program) => program.runs.where(
            (run) => run.startTime.isAfter(now),
          ),
        )
        .toList();
  }
}

extension TimeOfDayX on TimeOfDay {
  static String toJson(TimeOfDay timeOfDay) {
    return '${timeOfDay.hour}:${timeOfDay.minute}';
  }

  static TimeOfDay fromJson(String json) {
    final splits = json.split(':');
    return TimeOfDay(
      hour: int.parse(splits[0]),
      minute: int.parse(splits[1]),
    );
  }

  bool isBefore(DateTime dateTime) {
    final now = clock.now();
    final time = DateTime(
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    return time.isBefore(dateTime);
  }

  bool isAfter(DateTime dateTime) {
    return !isBefore(dateTime);
  }
}

extension ListRunX on List<Run> {
  List<RunGroup> toRunGroups() {
    final mods = <RunGroup>[];
    forEach((run) {
      final addedMod = mods.singleWhereOrNull(
        (RunGroup mod) =>
            mod.timeOfDay == run.startTime &&
            mod.duration.inSeconds == run.durationSeconds,
      );
      if (addedMod == null) {
        // A runGroup containing this run has not
        // been created yet
        mods.add(
          RunGroup(
            type: RunGroupType.modification,
            timeOfDay: run.startTime,
            zoneIds: [run.zoneId],
            duration: Duration(seconds: run.durationSeconds),
          ),
        );
      } else {
        // Add this run's zoneId to the run draft
        final index = mods.indexWhere(
          (element) => element.timeOfDay == addedMod.timeOfDay,
        );
        mods[index] =
            addedMod.copyWith(zoneIds: [run.zoneId, ...addedMod.zoneIds]);
      }
    });
    return mods;
  }
}

extension RunX on Run {
  TimeOfDay get startTime => TimeOfDay(hour: startHour, minute: startMinute);
}

extension ZoneX on Zone {
  int get nextRunMillisecondsSinceEpoch {
    final currentTimeEpochMillis = clock.now().millisecondsSinceEpoch;
    final millisUntilNextRun = timeUntilNextRunSec * 1000;
    return currentTimeEpochMillis + millisUntilNextRun;
  }

  DateTime get dateTimeOfNextRun {
    return DateTime.fromMillisecondsSinceEpoch(nextRunMillisecondsSinceEpoch);
  }
}
