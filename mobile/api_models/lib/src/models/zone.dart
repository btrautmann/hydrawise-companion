import 'package:freezed_annotation/freezed_annotation.dart';

part 'zone.freezed.dart';
part 'zone.g.dart';

@freezed
class Zone with _$Zone {
  factory Zone({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'zone_num') required int number,
    @JsonKey(name: 'zone_name') required String name,
    @JsonKey(name: 'time_until_run_sec') required int timeUntilNextRunSec,
    @JsonKey(name: 'run_length_sec') required int runLengthSec,
  }) = _Zone;

  factory Zone.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ZoneFromJson(json);
}

extension ZoneX on Zone {
  bool get isRunning => timeUntilNextRunSec == 1;

  bool get isSuspended => timeUntilNextRunSec == 1576800000;
}
