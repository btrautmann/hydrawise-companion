import 'package:clock/clock.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrawise/hydrawise.dart';

part 'customer_details.freezed.dart';
part 'customer_details.g.dart';

@freezed
class HCustomerDetails with _$HCustomerDetails {
  factory HCustomerDetails({
    @JsonKey(name: 'controller_id') required int activeControllerId,
    @JsonKey(name: 'customer_id') required int customerId,
    @JsonKey(name: 'controllers')
        required List<HydrawiseController> controllers,
  }) = _HCustomerDetails;

  factory HCustomerDetails.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$HCustomerDetailsFromJson(json);
}

extension CustomerDetailsX on HCustomerDetails {
  HCustomer toCustomer(String apiKey) {
    return HCustomer(
      activeControllerId: activeControllerId,
      customerId: customerId,
      apiKey: apiKey,
      lastStatusUpdate: clock.now().millisecondsSinceEpoch,
    );
  }
}
