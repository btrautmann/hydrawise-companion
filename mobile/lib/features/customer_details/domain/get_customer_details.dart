import 'package:irri/core/core.dart';
import 'package:irri/core/networking/http_client.dart';
import 'package:irri/features/auth/auth.dart';
import 'package:irri/features/customer_details/customer_details.dart';
import 'package:result_type/result_type.dart';

class GetCustomerDetails {
  GetCustomerDetails({
    required HttpClient httpClient,
    required GetApiKey getApiKey,
    required CustomerDetailsRepository repository,
  })  : _httpClient = httpClient,
        _getApiKey = getApiKey,
        _repository = repository;

  final HttpClient _httpClient;
  final GetApiKey _getApiKey;
  final CustomerDetailsRepository _repository;

  Future<UseCaseResult<CustomerDetails, String>> call() async {
    final apiKey = await _getApiKey();

    final queryParameters = {
      'api_key': apiKey!,
      'type': 'controllers',
    };

    final response = await _httpClient.get<Map<String, dynamic>>(
      'customerdetails.php',
      queryParameters: queryParameters,
    );

    if (response.isSuccess) {
      final customerDetails = CustomerDetails.fromJson(response.success!);

      final customerIdentification = customerDetails.toCustomer(apiKey);

      await _repository.insertCustomer(customerIdentification);

      return Success(customerDetails);
    }

    return Failure("Can't fetch customer details");
  }
}
