import 'package:hydrawise/hydrawise.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Login {
  final PostgreSQLConnection db;

  Login(this.db);

  Future<Response> call(Request request) async {
    final queryParams = request.url.queryParameters;

    final response = await http.get(
      Uri.http(
        'api.hydrawise.com',
        '/api/v1/customerdetails.php',
        queryParams,
      ),
    );

    if (response.statusCode == 200) {
      final details = CustomerDetails.fromJson(json.decode(response.body));
      final existingCustomerResults =
          await db.query(_customerExistsSql(details));
      if (existingCustomerResults.isEmpty) {
        print('Inserting a new customer.');
        await db.execute(_insertCustomerSql(details, queryParams['api_key']!));
      } else {
        print('Customer already exists, not inserting.');
      }
    }

    return Response(response.statusCode, body: response.body);
  }

  String _customerExistsSql(CustomerDetails details) {
    return 'SELECT * FROM customer WHERE customer.customer_id = ${details.customerId}';
  }

  String _insertCustomerSql(CustomerDetails details, String apiKey) {
    return 'INSERT INTO customer (customer_id, api_key, active_controller_id) '
        'VALUES (${details.customerId}, \'$apiKey\', ${details.activeControllerId});';
  }
}
