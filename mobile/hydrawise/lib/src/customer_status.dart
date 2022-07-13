import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrawise/hydrawise.dart';

part 'customer_status.freezed.dart';
part 'customer_status.g.dart';

@freezed
class HCustomerStatus with _$HCustomerStatus {
  factory HCustomerStatus({
    @JsonKey(name: 'nextpoll') required int numberOfSecondsUntilNextRequest,
    @JsonKey(name: 'time') required int timeOfLastStatusUnixEpoch,
    @JsonKey(name: 'relays') required List<HZone> zones,
  }) = _HCustomerStatus;

  factory HCustomerStatus.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$HCustomerStatusFromJson(json);
}
