import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hydrawise/customer_details/models/customer_details.dart';

typedef GetCustomerDetails = Future<CustomerDetails> Function(String apiKey);

class GetRealCustomerDetails {
  Future<CustomerDetails> call(String apiKey) async {
    final response = await http.get(
      Uri.parse('https://api.hydrawise.com/api/v1/customerdetails.php'),
    );
    return CustomerDetails.fromJson(
      json.decode(response.body) as Map<String, dynamic>,
    );
  }
}

class GetFakeCustomerDetails {
  Future<CustomerDetails> call(String apiKey) async {
    return CustomerDetails(
      controllerId: 1234,
      customerId: 5678,
    );
  }
}
