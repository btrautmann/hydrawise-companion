import 'package:api_models/api_models.dart';
import 'package:core/core.dart';

class GetCustomerDetails {
  GetCustomerDetails({
    required HttpClient httpClient,
  }) : _httpClient = httpClient;

  final HttpClient _httpClient;

  Future<GetCustomerResponse> call() async {
    final response = await _httpClient.get<Map<String, dynamic>>('customer');

    if (response.isSuccess) {
      final getCustomerResponse = GetCustomerResponse.fromJson(response.success!);
      return getCustomerResponse;
    } else {
      throw Exception(response.failure);
    }
  }
}
