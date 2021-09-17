import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hydrawise/customer_details/api/domain/get_api_key.dart';
import 'package:hydrawise/customer_details/models/customer_details.dart';
import 'package:hydrawise/customer_details/models/customer_identification.dart';
import 'package:sqflite/sqlite_api.dart';

typedef GetCustomerDetails = Future<CustomerDetails> Function();

class GetCustomerDetailsFromNetwork {
  GetCustomerDetailsFromNetwork({
    required GetApiKey getApiKey,
    required Database database,
  })  : _getApiKey = getApiKey,
        _database = database;

  final GetApiKey _getApiKey;
  final Database _database;

  Future<CustomerDetails> call() async {
    final apiKey = await _getApiKey();

    final queryParameters = {
      'api_key': apiKey,
      'type': 'controllers',
    };
    final uri = Uri.https(
      'api.hydrawise.com',
      '/api/v1/customerdetails.php',
      queryParameters,
    );
    // TODO(brandon): Handle error case
    final response = await http.get(uri);

    final customerDetails = CustomerDetails.fromJson(
      json.decode(response.body) as Map<String, dynamic>,
    );

    final customerIdentification =
        customerDetails.toCustomerIdentification(apiKey!);

    await _database.insert(
      'customers',
      customerIdentification.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return customerDetails;
  }
}

class GetFakeCustomerDetails {
  GetFakeCustomerDetails({
    required Database database,
  }) : _database = database;

  final Database _database;

  Future<CustomerDetails> call() async {
    final customers = await _database.query('customers');

    if (customers.isEmpty) {
      // Insert a dummy customer
      final fakeCustomer = CustomerIdentification(
        activeControllerId: 1234,
        customerId: 5678,
        apiKey: '1212',
        lastStatusUpdate: DateTime.now().millisecondsSinceEpoch,
      );
      await _database.insert('customers', fakeCustomer.toJson());
    }

    // Query again for simplicity
    final finalCustomers = await _database.query('customers');

    final customer = CustomerIdentification.fromJson(finalCustomers.first);

    return CustomerDetails(
      activeControllerId: customer.activeControllerId,
      customerId: customer.customerId,
      controllers: List.empty(),
    );
  }
}
