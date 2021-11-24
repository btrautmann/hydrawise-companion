import 'package:hydrawise/core/core.dart';
import 'package:hydrawise/core/networking/http_client.dart';
import 'package:hydrawise/features/auth/auth.dart';
import 'package:hydrawise/features/customer_details/customer_details.dart';
import 'package:result_type/result_type.dart';

typedef GetCustomerDetails = Future<UseCaseResult<CustomerDetails, String>> Function();

class GetCustomerDetailsFromHydrawise {
  GetCustomerDetailsFromHydrawise({
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

      final customerIdentification = customerDetails.toCustomerIdentification(apiKey);

      await _repository.insertCustomer(customerIdentification);

      return Success(customerDetails);
    }

    return Failure("Can't fetch customer details");
  }
}

class GetFakeCustomerDetails {
  GetFakeCustomerDetails({
    required CustomerDetailsRepository repository,
  }) : _repository = repository;

  final CustomerDetailsRepository _repository;

  Future<UseCaseResult<CustomerDetails, String>> call() async {
    final customers = await _repository.getCustomers();

    if (customers.isEmpty) {
      // Insert a dummy customer
      final fakeCustomer = CustomerIdentification(
        activeControllerId: 1234,
        customerId: 5678,
        apiKey: '1212',
        lastStatusUpdate: 1631330889,
      );
      await _repository.insertCustomer(fakeCustomer);
    }

    // Query again for simplicity
    final customer = await _repository.getCustomer();

    return Success(CustomerDetails(
      activeControllerId: customer.activeControllerId,
      customerId: customer.customerId,
      controllers: [
        Controller(
          name: 'Fake Controller',
          lastContact: 1631616496,
          serialNumber: '123456789',
          id: 1234,
          status: 'All good!',
        ),
      ],
    ));
  }
}
