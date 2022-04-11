import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrawise/hydrawise.dart';

part 'customer_status.freezed.dart';
part 'customer_status.g.dart';

@freezed
class CustomerStatus with _$CustomerStatus {
  factory CustomerStatus({
    @JsonKey(name: 'nextpoll') required int numberOfSecondsUntilNextRequest,
    @JsonKey(name: 'time') required int timeOfLastStatusUnixEpoch,
    @JsonKey(name: 'relays') required List<Zone> zones,
  }) = _CustomerStatus;

  factory CustomerStatus.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$CustomerStatusFromJson(json);
}
