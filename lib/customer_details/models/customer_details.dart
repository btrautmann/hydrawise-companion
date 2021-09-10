import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_details.freezed.dart';
part 'customer_details.g.dart';

@freezed
class CustomerDetails with _$CustomerDetails {
  factory CustomerDetails({
    @JsonKey(name: 'controller_id') required int controllerId,
    @JsonKey(name: 'customer_id') required int customerId,
  }) = _CustomerDetails;

  factory CustomerDetails.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$CustomerDetailsFromJson(json);
}
