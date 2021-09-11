import 'package:freezed_annotation/freezed_annotation.dart';

part 'zone.freezed.dart';
part 'zone.g.dart';

@freezed
class Zone with _$Zone {
  factory Zone({
    @JsonKey(name: 'relay_id') required int id,
    @JsonKey(name: 'relay') required int physicalNumber,
    @JsonKey(name: 'timestr') required String nextTimeOfWaterFriendly,
    // Value will be 1 if a watering is in progress
    @JsonKey(name: 'time') required int nextTimeOfWaterSeconds,
    // If run is in progress, indicates time remaining
    @JsonKey(name: 'run') required int lengthOfNextRunTimeOrTimeRemaining,
  }) = _Zone;

  factory Zone.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ZoneFromJson(json);
}
