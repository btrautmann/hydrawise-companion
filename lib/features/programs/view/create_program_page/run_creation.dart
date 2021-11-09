import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrawise/features/customer_details/customer_details.dart';

part 'run_creation.freezed.dart';

@freezed
class RunCreation with _$RunCreation {
  factory RunCreation({
    TimeOfDay? timeOfDay,
    List<Zone>? zones,
    Duration? duration,
  }) = _RunCreation;
}
