import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer.freezed.dart';
part 'customer.g.dart';

@freezed
class Customer with _$Customer {
  factory Customer({
    @JsonKey(name: 'controller_id') required int activeControllerId,
    @JsonKey(name: 'customer_id') required int customerId,
    @JsonKey(name: 'api_key') required String apiKey,
    @JsonKey(name: 'last_status_update') required int lastStatusUpdate,
    @Default(0) @JsonKey(name: 'time_zone_offset') int timeZoneOffsetMillis,
  }) = _Customer;

  factory Customer.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$CustomerFromJson(json);
}
