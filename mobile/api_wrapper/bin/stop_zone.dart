import 'dart:convert';

import 'package:api_models/api_models.dart';
import 'package:http/http.dart' as http;
import 'package:hydrawise/hydrawise.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';

class StopZone {
  StopZone(this.db);

  final PostgreSQLConnection db;

  Future<Response> call(Request request) async {
    final body = await request.readAsString();
    final stopZoneRequest = StopZoneRequest.fromJson(json.decode(body));

    // TODO(brandon): Auth interception
    final queryResults =
        await db.query(_findCustomerSql(stopZoneRequest.apiKey));
    if (queryResults.isEmpty) {
      return Response(401);
    }
    final customerId = queryResults.single.toColumnMap()['customer_id'] as int?;
    if (customerId == null) {
      return Response(401);
    }

    final queryParameters = <String, String>{
      'api_key': stopZoneRequest.apiKey,
      'action': 'stop',
      'relay_id': stopZoneRequest.zoneId.toString(),
    };

    final stopResponse = await http.get(
      Uri.http(
        'api.hydrawise.com',
        '/api/v1/setzone.php',
        queryParameters,
      ),
    );

    if (stopResponse.statusCode == 200) {
      final statusResponse = await http.get(
        Uri.http(
          'api.hydrawise.com',
          '/api/v1/statusschedule.php',
          Map.of(queryParameters)
            ..removeWhere((key, value) => key != 'api_key'),
        ),
      );
      if (statusResponse.statusCode == 200) {
        final status =
            HCustomerStatus.fromJson(json.decode(statusResponse.body));
        await db.transaction((connection) async {
          for (final zone in status.zones) {
            print('Inserting zone $zone');
            await connection.execute(_updateZoneSql(customerId, zone));
          }
        });
      }
    }

    return Response(stopResponse.statusCode, body: stopResponse.body);
  }

  String _findCustomerSql(String apiKey) =>
      'SELECT * FROM customer WHERE api_key=\'$apiKey\' LIMIT 1;';

  String _updateZoneSql(int customerId, HZone zone) => 'UPDATE zone '
      'SET time_until_run_sec = ${zone.secondsUntilNextRun}, run_length_sec = ${zone.lengthOfNextRunTimeOrTimeRemaining} '
      'WHERE zone_id = ${zone.id} AND customer_id = $customerId;';
}