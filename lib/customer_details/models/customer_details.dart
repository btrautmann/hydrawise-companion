import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_details.freezed.dart';
part 'customer_details.g.dart';

@freezed
class CustomerDetails with _$CustomerDetails {
  factory CustomerDetails({
    required int controllerId,
    required int customerId,
  }) = _CustomerDetails;

  factory CustomerDetails.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$CustomerDetailsFromJson(json);
}
