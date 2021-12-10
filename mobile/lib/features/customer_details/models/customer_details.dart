import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irri/features/customer_details/models/controller.dart';
import 'package:irri/features/customer_details/models/customer.dart';

part 'customer_details.freezed.dart';
part 'customer_details.g.dart';

@freezed
class CustomerDetails with _$CustomerDetails {
  factory CustomerDetails({
    @JsonKey(name: 'controller_id') required int activeControllerId,
    @JsonKey(name: 'customer_id') required int customerId,
    @JsonKey(name: 'controllers') required List<Controller> controllers,
  }) = _CustomerDetails;

  factory CustomerDetails.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$CustomerDetailsFromJson(json);
}

extension CustomerDetailsX on CustomerDetails {
  Customer toCustomer(String apiKey) {
    return Customer(
      activeControllerId: activeControllerId,
      customerId: customerId,
      apiKey: apiKey,
      // TODO(brandon): Use a framework we can
      // modify under test for time
      lastStatusUpdate: DateTime.now().millisecondsSinceEpoch,
    );
  }
}
