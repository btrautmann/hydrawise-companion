import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrawise/customer_details/models/customer_details.dart';
import 'package:hydrawise/customer_details/models/customer_status.dart';

part 'customer_details_state.freezed.dart';

@freezed
class CustomerDetailsState with _$CustomerDetailsState {
  factory CustomerDetailsState.loading() = _Loading;

  factory CustomerDetailsState.empty() = _Empty;

  factory CustomerDetailsState.complete({
    required CustomerDetails customerDetails,
    required CustomerStatus customerStatus,
  }) = _Complete;
}
