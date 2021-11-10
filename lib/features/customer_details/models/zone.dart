import 'package:freezed_annotation/freezed_annotation.dart';

part 'zone.freezed.dart';
part 'zone.g.dart';

@freezed
class Zone with _$Zone {
  factory Zone({
    @JsonKey(name: 'relay_id') required int id,
    @JsonKey(name: 'relay') required int physicalNumber,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'timestr') required String nextTimeOfWaterFriendly,
    // Value will be 1 if a watering is in progress
    @JsonKey(name: 'time') required int secondsUntilNextRun,
    // If run is in progress, indicates time remaining
    @JsonKey(name: 'run') required int lengthOfNextRunTimeOrTimeRemaining,
  }) = _Zone;

  factory Zone.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ZoneFromJson(json);
}

extension ZoneX on Zone {
  int get nextRunMillisecondsSinceEpoch {
    // TODO(brandon): Use a framework we can
    // modify under test for time
    final currentTimeEpochMillis = DateTime.now().millisecondsSinceEpoch;
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
