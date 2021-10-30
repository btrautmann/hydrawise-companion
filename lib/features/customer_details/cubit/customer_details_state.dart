part of 'customer_details_cubit.dart';

@freezed
class CustomerDetailsState with _$CustomerDetailsState {
  factory CustomerDetailsState.loading() = _Loading;

  factory CustomerDetailsState.empty() = _Empty;

  factory CustomerDetailsState.complete({
    required CustomerDetails customerDetails,
    required CustomerStatus customerStatus,
  }) = _Complete;
}
