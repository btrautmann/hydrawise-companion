import 'package:clock/clock.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'zone.freezed.dart';
part 'zone.g.dart';

@freezed
class HZone with _$HZone {
  factory HZone({
    @JsonKey(name: 'relay_id') required int id,
    @JsonKey(name: 'relay') required int physicalNumber,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'timestr') required String nextTimeOfWaterFriendly,
    // Value will be 1 if a watering is in progress
    @JsonKey(name: 'time') required int secondsUntilNextRun,
    // If run is in progress, indicates time remaining
    @JsonKey(name: 'run') required int lengthOfNextRunTimeOrTimeRemaining,
  }) = _HZone;

  factory HZone.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$HZoneFromJson(json);
}

extension HZoneX on HZone {
  int get nextRunMillisecondsSinceEpoch {
    final currentTimeEpochMillis = clock.now().millisecondsSinceEpoch;
    final millisUntilNextRun = secondsUntilNextRun * 1000;
    return currentTimeEpochMillis + millisUntilNextRun;
  }

  DateTime get dateTimeOfNextRun {
    return DateTime.fromMillisecondsSinceEpoch(nextRunMillisecondsSinceEpoch);
  }

  bool get isRunning {
    return secondsUntilNextRun == 1;
  }

  bool get isSuspended {
    return secondsUntilNextRun == 1576800000;
  }
}
