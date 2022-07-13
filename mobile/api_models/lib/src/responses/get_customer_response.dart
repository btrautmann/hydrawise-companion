import 'package:api_models/api_models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_customer_response.freezed.dart';
part 'get_customer_response.g.dart';

@freezed
class GetCustomerResponse with _$GetCustomerResponse {
  factory GetCustomerResponse({
    @JsonKey(name: 'customer') required Customer customer,
    @JsonKey(name: 'zones') required List<Zone> zones,
  }) = _GetCustomerResponse;

  factory GetCustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$GetCustomerResponseFromJson(json);
}
