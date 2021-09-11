import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hydrawise/customer_details/models/customer_details.dart';

typedef GetCustomerDetails = Future<CustomerDetails> Function(String apiKey);

class GetRealCustomerDetails {
  Future<CustomerDetails> call(String apiKey) async {
    final queryParameters = {
      'api_key': apiKey,
      'type': 'controllers',
    };
    final uri = Uri.https(
      'api.hydrawise.com',
      '/api/v1/customerdetails.php',
      queryParameters,
    );
    final response = await http.get(uri);
    return CustomerDetails.fromJson(
      json.decode(response.body) as Map<String, dynamic>,
    );
  }
}

class GetFakeCustomerDetails {
  Future<CustomerDetails> call(String apiKey) async {
    return CustomerDetails(
      activeControllerId: 1234,
      customerId: 5678,
      controllers: [],
    );
  }
}
