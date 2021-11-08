import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'start_time.freezed.dart';

@freezed
class StartTime with _$StartTime {
  factory StartTime({
    required String id,
    required TimeOfDay time, // TEXT COLUMN in `program_start_times`
    required List<int> zoneIds, // INTEGER (id) COLUMN `program_start_time_zones`
  }) = _StartTime;

  static StartTime fromJson(Map<String, dynamic> json) {
    final timeString = json['time'] as String;
    final splits = timeString.split(':');
    final timeOfDay = TimeOfDay(
      hour: int.parse(splits[0]),
      minute: int.parse(splits[1]),
    );
    final zoneIds = (json['zone_ids'] as String).replaceAll('[', '').replaceAll(']', '').split(',');
    return StartTime(
      id: json['id'] as String,
      time: timeOfDay,
      zoneIds: (zoneIds.isEmpty || zoneIds.first.isEmpty) ? List.empty() : zoneIds.map((e) => int.parse(e)).toList(),
    );
  }
}

extension StartTimeX on StartTime {
  Map<String, dynamic> toJson(String programName) {
    return {
      'id': id,
      'program_name': programName,
      'time': '${time.hour}:${time.minute}',
      'zone_ids': '[' +
          List.generate(
            zoneIds.length,
            (index) => zoneIds[index].toString(),
          ).join(',') +
          ']'
    };
  }
}
