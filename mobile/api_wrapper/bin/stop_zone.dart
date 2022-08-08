import 'dart:convert';

import 'package:api_models/api_models.dart';
import 'package:http/http.dart' as http;
import 'package:hydrawise/hydrawise.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';

import 'extensions.dart';

class StopZone {
  StopZone(this.db);

  final PostgreSQLConnection db;

  Future<Response> call(Request request) async {
    final body = await request.readAsString();
    final stopZoneRequest = StopZoneRequest.fromJson(json.decode(body));

    final customerId = request.customerId;

    final queryParameters = <String, String>{
      'api_key': request.apiKey,
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
          Map.of(queryParameters)..removeWhere((key, value) => key != 'api_key'),
        ),
      );
      if (statusResponse.statusCode == 200) {
        final status = HCustomerStatus.fromJson(json.decode(statusResponse.body));
        await db.transaction((connection) async {
          for (final zone in status.zones) {
            await connection.query(_updateZoneSql(customerId, zone));
          }
        });
        final runZoneResponse = RunZoneResponse(
          zones: status.zones
              .map(
                (e) => Zone(
                  id: e.id,
                  number: e.physicalNumber,
                  name: e.name,
                  timeUntilNextRunSec: e.secondsUntilNextRun,
                  runLengthSec: e.lengthOfNextRunTimeOrTimeRemaining,
                ),
              )
              .toList(),
        );
        return Response.ok(
          jsonEncode(runZoneResponse),
        );
      }
    }

    return Response(stopResponse.statusCode, body: stopResponse.body);
  }

  String _updateZoneSql(int customerId, HZone zone) => 'UPDATE zone '
      'SET time_until_run_sec = ${zone.secondsUntilNextRun}, run_length_sec = ${zone.lengthOfNextRunTimeOrTimeRemaining} '
      'WHERE zone_id = ${zone.id} AND customer_id = $customerId;';
}
