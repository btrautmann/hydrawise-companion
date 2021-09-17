import 'package:freezed_annotation/freezed_annotation.dart';

part 'run_zone_state.freezed.dart';

@freezed
class RunZoneState with _$RunZoneState {
  factory RunZoneState.resting() = _Resting;

  factory RunZoneState.loading() = _Loading;
}
