import 'package:clock/clock.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irri/programs/models/run_group.dart';

part 'run.freezed.dart';
part 'run.g.dart';

@freezed
class Run extends Equatable with _$Run {
  factory Run({
    @JsonKey(name: 'id')
        required String id,
    @JsonKey(name: 'p_id')
        required String programId,
    @JsonKey(
      name: 'start_time',
      toJson: TimeOfDayX.toJson,
      fromJson: TimeOfDayX.fromJson,
    )
        required TimeOfDay startTime,
    @JsonKey(name: 'duration')
        required int duration,
    @JsonKey(name: 'z_id')
        required int zoneId,
  }) = _Run;

  factory Run.fromJson(Map<String, dynamic> json) => _$RunFromJson(json);

  @override
  List<Object?> get props => [programId, startTime, duration, zoneId];
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
        (mod) =>
            mod.timeOfDay == run.startTime &&
            mod.duration.inSeconds == run.duration,
      );
      if (addedMod == null) {
        // A runGroup containing this run has not
        // been created yet
        mods.add(
          RunGroup(
            type: RunGroupType.modification,
            timeOfDay: run.startTime,
            zoneIds: [run.zoneId],
            duration: Duration(seconds: run.duration),
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
