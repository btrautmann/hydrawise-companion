import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrawise/features/programs/models/run_draft.dart';

part 'run.freezed.dart';
part 'run.g.dart';

@freezed
class Run with _$Run {
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
    final now = DateTime.now();
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
  List<RunDraft> toRunModifications() {
    final mods = <RunDraft>[];
    forEach((run) {
      final addedMod = mods.singleWhereOrNull(
        (mod) =>
            mod.timeOfDay == run.startTime &&
            mod.duration.inSeconds == run.duration,
      );
      if (addedMod == null) {
        // A runDraft containing this run has not
        // been created yet
        mods.add(
          RunDraft.modification(
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
