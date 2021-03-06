import 'dart:convert';

import 'package:api_models/api_models.dart';
import 'package:http/http.dart' as http;
import 'package:hydrawise/hydrawise.dart' hide HCustomer;
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';

import 'extensions.dart';

/// Calls the customer details and customer states endpoints
/// and if successful, inserts the customer and their zones
/// into the database
class Login {
  Login(this.db);

  final PostgreSQLConnection db;

  Future<Response> call(Request request) async {
    print('Received a call to /login');
    final body = await request.readAsString();
    final loginRequest = LoginRequest.fromJson(json.decode(body));
    final apiKey = request.apiKey;

    final queryParameters = <String, dynamic>{
      'api_key': apiKey,
      'type': loginRequest.type,
    };

    final detailsResponse = await http.get(
      Uri.http(
        'api.hydrawise.com',
        '/api/v1/customerdetails.php',
        queryParameters,
      ),
    );

    if (detailsResponse.statusCode == 200) {
      final details = HCustomerDetails.fromJson(json.decode(detailsResponse.body));
      final statusResponse = await http.get(
        Uri.http(
          'api.hydrawise.com',
          '/api/v1/statusschedule.php',
          Map.of(queryParameters)..removeWhere((key, value) => key != 'api_key'),
        ),
      );
      if (statusResponse.statusCode == 200) {
        final status = HCustomerStatus.fromJson(json.decode(statusResponse.body));
        await db.transaction((connection) async {
          await connection.query(
            _insertCustomerSql(details, queryParameters['api_key']!),
          );
          for (final zone in status.zones) {
            await connection.query(_insertZoneSql(details, zone));
          }
        });

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

  // TODO(brandon): Add DO UPDATE clause to allow changing API key
  String _insertCustomerSql(HCustomerDetails details, String apiKey) =>
      'INSERT INTO customer (customer_id, api_key, active_controller_id) '
      'VALUES (${details.customerId}, \'$apiKey\', ${details.activeControllerId}) '
      'ON CONFLICT (customer_id, api_key) DO NOTHING;';

  String _insertZoneSql(HCustomerDetails details, HZone zone) =>
      'INSERT INTO zone (zone_id, customer_id, time_until_run_sec, run_length_sec, zone_num, zone_name) '
      'VALUES (${zone.id}, ${details.customerId}, ${zone.secondsUntilNextRun}, ${zone.lengthOfNextRunTimeOrTimeRemaining}, ${zone.physicalNumber}, \'${zone.name}\') '
      'ON CONFLICT (zone_id, customer_id) DO NOTHING;';
}
