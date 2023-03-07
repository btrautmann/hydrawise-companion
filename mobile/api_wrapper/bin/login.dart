import 'dart:convert';

import 'package:api_models/api_models.dart';
import 'package:http/http.dart' as client;
import 'package:hydrawise/hydrawise.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';

import '../db/queries/insert_customer.dart';
import 'extensions.dart';

class Login {
  Login(this.db) : _insertCustomer = InsertCustomer(db);

  final PostgreSQLConnection Function() db;
  final InsertCustomer _insertCustomer;

  Future<Response> call(Request request) async {
    final body = await request.readAsString();
    final loginRequest = LoginRequest.fromJson(json.decode(body));
    final apiKey = request.apiKey;

    final queryParameters = <String, dynamic>{
      'api_key': apiKey,
      'type': loginRequest.type,
    };

    final detailsResponse = await client.get(
      Uri.http(
        'api.hydrawise.com',
        '/api/v1/customerdetails.php',
        queryParameters,
      ),
    );

    if (detailsResponse.statusCode == 200) {
      final details = HCustomerDetails.fromJson(json.decode(detailsResponse.body));
      final statusResponse = await client.get(
        Uri.http(
          'api.hydrawise.com',
          '/api/v1/statusschedule.php',
          <String, dynamic>{
            'api_key': apiKey,
            'controller_id': details.activeControllerId.toString(),
          },
        ),
      );
      if (statusResponse.statusCode == 200) {
        final status = HCustomerStatus.fromJson(json.decode(statusResponse.body));
        await _insertCustomer(apiKey: apiKey, details: details, status: status);

        return Response.ok(
          jsonEncode(
            LoginResponse(
              customer: Customer(
                customerId: details.customerId,
                activeControllerId: details.activeControllerId,
              ),
            ),
          ),
          headers: {'Content-Type': 'application/json'},
        );
      }
    }
    return Response(401);
  }
}
