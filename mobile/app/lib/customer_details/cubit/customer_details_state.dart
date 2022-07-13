part of 'customer_details_cubit.dart';

@freezed
class CustomerDetailsState with _$CustomerDetailsState {
  factory CustomerDetailsState.loading() = _Loading;

  factory CustomerDetailsState.complete({
    required Customer customerDetails,
    required List<Zone> zones,
  }) = _Complete;
}
