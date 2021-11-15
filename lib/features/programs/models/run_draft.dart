import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'run_draft.freezed.dart';

@freezed
class RunDraft with _$RunDraft {
  factory RunDraft.creation({
    required TimeOfDay timeOfDay,
    required List<int> zoneIds,
    required Duration duration,
  }) = _RunCreation;

  factory RunDraft.modification({
    required TimeOfDay timeOfDay,
    required List<int> zoneIds,
    required Duration duration,
  }) = _RunModification;
}

extension RunDraftX on RunDraft {
  bool isNewRunDraft() {
    return map(creation: (_) => true, modification: (_) => false);
  }
}
