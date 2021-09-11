import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrawise/customer_details/models/zone.dart';

part 'customer_status.freezed.dart';
part 'customer_status.g.dart';

@freezed
class CustomerStatus with _$CustomerStatus {
  factory CustomerStatus({
    @JsonKey(name: 'message') required String statusMessage,
    @JsonKey(name: 'nextpoll') required int numberOfSecondsUntilNextRequest,
    @JsonKey(name: 'time') required int timeOfLastStatusUnixEpoch,
    @JsonKey(name: 'relays') required List<Zone> zones,
    @JsonKey(name: 'master') int? masterZoneNumber,
    @JsonKey(name: 'master_timer') int? zoneDelay,
  }) = _CustomerStatus;

  factory CustomerStatus.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$CustomerStatusFromJson(json);
}
