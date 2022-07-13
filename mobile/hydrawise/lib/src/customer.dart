import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer.freezed.dart';
part 'customer.g.dart';

@freezed
class HCustomer with _$HCustomer {
  factory HCustomer({
    @JsonKey(name: 'controller_id') required int activeControllerId,
    @JsonKey(name: 'customer_id') required int customerId,
    @JsonKey(name: 'api_key') required String apiKey,
    @JsonKey(name: 'last_status_update') required int lastStatusUpdate,
    @Default('America/New_York') @JsonKey(name: 'time_zone') String? timeZone,
  }) = _HCustomer;

  factory HCustomer.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$HCustomerFromJson(json);
}
