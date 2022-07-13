import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:hydrawise/hydrawise.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';

/// Calls the customer details and customer states endpoints
/// and if successful, inserts the customer and their zones
/// into the database
class Login {
  Login(this.db);

  final PostgreSQLConnection db;

  Future<Response> call(Request request) async {
    final queryParams = request.url.queryParameters;

    final detailsResponse = await http.get(
      Uri.http(
        'api.hydrawise.com',
        '/api/v1/customerdetails.php',
        queryParams,
      ),
    );

    if (detailsResponse.statusCode == 200) {
      final details =
          CustomerDetails.fromJson(json.decode(detailsResponse.body));
      final queryParams = Map.of(request.url.queryParameters)
        ..removeWhere((key, value) => key != 'api_key');
      final statusResponse = await http.get(
        Uri.http(
          'api.hydrawise.com',
          '/api/v1/statusschedule.php',
          queryParams,
        ),
      );
      if (statusResponse.statusCode == 200) {
        final status =
            CustomerStatus.fromJson(json.decode(statusResponse.body));
        await db.transaction((connection) async {
          print('Inserting customer ${details.customerId}');
          await connection
              .execute(_insertCustomerSql(details, queryParams['api_key']!));
          for (final zone in status.zones) {
            print('Inserting zone ${zone.id}');
            await connection.execute(_insertZoneSql(details, zone));
          }
        });

        return Response(detailsResponse.statusCode, body: detailsResponse.body);
      }
    }
    return Response(401);
  }

  // TODO(brandon): Add DO UPDATE clause to allow changing API key
  String _insertCustomerSql(CustomerDetails details, String apiKey) {
    return 'INSERT INTO customer (customer_id, api_key, active_controller_id) '
        'VALUES (${details.customerId}, \'$apiKey\', ${details.activeControllerId}) '
        'ON CONFLICT (customer_id, api_key) DO NOTHING;';
  }

  String _insertZoneSql(CustomerDetails details, Zone zone) {
    return 'INSERT INTO zone (zone_id, customer_id, time_until_run_sec, run_length_sec, zone_num, zone_name) '
        'VALUES (${zone.id}, ${details.customerId}, ${zone.secondsUntilNextRun}, ${zone.lengthOfNextRunTimeOrTimeRemaining}, ${zone.physicalNumber}, \'${zone.name}\') '
        'ON CONFLICT (zone_id, customer_id) DO NOTHING;';
  }
}
