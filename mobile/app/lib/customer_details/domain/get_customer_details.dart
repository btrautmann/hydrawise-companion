import 'package:api_models/api_models.dart';
import 'package:core/core.dart';
import 'package:irri/customer_details/customer_details.dart';
import 'package:result_type/result_type.dart';

class GetCustomerDetails {
  GetCustomerDetails({
    required HttpClient httpClient,
    required CustomerDetailsRepository repository,
  })  : _httpClient = httpClient,
        _repository = repository;

  final HttpClient _httpClient;
  final CustomerDetailsRepository _repository;

  Future<UseCaseResult<GetCustomerResponse, String>> call() async {
    final response = await _httpClient.get<Map<String, dynamic>>('customer');

    if (response.isSuccess) {
      final getCustomerResponse = GetCustomerResponse.fromJson(response.success!);

      await _repository.insertCustomer(getCustomerResponse.customer);
      for (final zone in getCustomerResponse.zones) {
        await _repository.insertZone(zone);
      }

      return Success(getCustomerResponse);
    }

    return Failure(response.failure.message);
  }
}
