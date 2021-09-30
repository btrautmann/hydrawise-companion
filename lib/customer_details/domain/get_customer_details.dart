import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hydrawise/core/networking/http_client.dart';
import 'package:hydrawise/customer_details/api/domain/get_api_key.dart';
import 'package:hydrawise/customer_details/models/controller.dart';
import 'package:hydrawise/customer_details/models/customer_details.dart';
import 'package:hydrawise/customer_details/models/customer_identification.dart';
import 'package:hydrawise/customer_details/repository/customer_details_repository.dart';

typedef GetCustomerDetails = Future<CustomerDetails> Function();

class GetCustomerDetailsFromNetwork {
  GetCustomerDetailsFromNetwork({
    required HttpClient httpClient,
    required GetApiKey getApiKey,
    required CustomerDetailsRepository repository,
  })  : _httpClient = httpClient,
        _getApiKey = getApiKey,
        _repository = repository;

  final HttpClient _httpClient;
  final GetApiKey _getApiKey;
  final CustomerDetailsRepository _repository;

  Future<CustomerDetails> call() async {
    final apiKey = await _getApiKey();

    final queryParameters = {
      'api_key': apiKey!,
      'type': 'controllers',
    };

    final response = await _httpClient.get<Map<String, dynamic>>(
      'customerdetails.php',
      queryParameters: queryParameters,
    );

    final customerDetails = CustomerDetails.fromJson(response.data!);

    final customerIdentification =
        customerDetails.toCustomerIdentification(apiKey!);

    await _repository.insertCustomer(customerIdentification);

    return customerDetails;
  }
}

class GetFakeCustomerDetails {
  GetFakeCustomerDetails({
    required CustomerDetailsRepository repository,
  }) : _repository = repository;

  final CustomerDetailsRepository _repository;

  Future<CustomerDetails> call() async {
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

    await Future<void>.delayed(const Duration(seconds: 1));

    return CustomerDetails(
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
    );
  }
}
