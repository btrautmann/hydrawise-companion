import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'run.freezed.dart';
part 'run.g.dart';

@freezed
class Run with _$Run {
  factory Run({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'p_id') required String programId,
    @JsonKey(name: 'start_time', toJson: TimeOfDayX.toJson, fromJson: TimeOfDayX.fromJson) required TimeOfDay startTime,
    @JsonKey(name: 'duration') required int duration,
    @JsonKey(name: 'z_id') required int zoneId,
  }) = _Run;

  factory Run.fromJson(Map<String, dynamic> json) => _$RunFromJson(json);
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
}
