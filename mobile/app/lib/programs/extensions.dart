import 'package:api_models/api_models.dart';
import 'package:clock/clock.dart';
import 'package:flutter/material.dart';

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

extension ZoneX on Zone {
  int get nextRunMillisecondsSinceEpoch {
    if (nextRunStart == null) {
      return 0;
    }
    return DateTime.parse(nextRunStart!).millisecondsSinceEpoch;
  }

  DateTime get dateTimeOfNextRun {
    return DateTime.fromMillisecondsSinceEpoch(nextRunMillisecondsSinceEpoch);
  }
}
