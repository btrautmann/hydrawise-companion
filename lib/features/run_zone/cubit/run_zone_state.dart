part of 'run_zone_cubit.dart';

@freezed
class RunZoneState with _$RunZoneState {
  factory RunZoneState.resting({String? message}) = _Resting;

  factory RunZoneState.loading() = _Loading;
}
