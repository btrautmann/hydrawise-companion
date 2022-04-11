import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'run_group.freezed.dart';

enum RunGroupType { creation, modification }

@freezed
class RunGroup with _$RunGroup {
  factory RunGroup({
    required RunGroupType type,
    required TimeOfDay timeOfDay,
    required List<int> zoneIds,
    required Duration duration,
  }) = _RunGroup;
}

extension RunGroupX on RunGroup {
  bool isNewRunGroup() {
    return type == RunGroupType.creation;
  }
}
