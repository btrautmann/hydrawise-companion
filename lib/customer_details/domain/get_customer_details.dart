import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hydrawise/customer_details/api/domain/get_api_key.dart';
import 'package:hydrawise/customer_details/models/controller.dart';
import 'package:hydrawise/customer_details/models/customer_details.dart';
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
  Future<CustomerDetails> call() async {
    return CustomerDetails(
      activeControllerId: 1234,
      customerId: 5678,
      controllers: [
        Controller(
          name: 'Fake Controller',
          lastContact: 1631616496,
          serialNumber: '123456789',
          id: 1234,
          status: 'All good!',
        )
      ],
    );
  }
}
