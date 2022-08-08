import 'dart:convert';

import 'package:api_models/api_models.dart';
import 'package:http/http.dart' as http;
import 'package:hydrawise/hydrawise.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';

import 'extensions.dart';

class RunZone {
  RunZone(this.db);

  final PostgreSQLConnection db;

  Future<Response> call(Request request) async {
    final body = await request.readAsString();
    final runZoneRequest = RunZoneRequest.fromJson(json.decode(body));

    final customerId = request.customerId;
    final apiKey = request.apiKey;

    final queryParameters = <String, String>{
      'api_key': apiKey,
      'action': 'run',
      'period_id': '999',
      'custom': runZoneRequest.runLengthSeconds.toString(),
      'relay_id': runZoneRequest.zoneId.toString(),
    };

    final runResponse = await http.get(
      Uri.http(
        'api.hydrawise.com',
        '/api/v1/setzone.php',
        queryParameters,
      ),
    );

    if (runResponse.statusCode == 200) {
      final statusResponse = await http.get(
        Uri.http(
          'api.hydrawise.com',
          '/api/v1/statusschedule.php',
          Map.of(queryParameters)..removeWhere((key, value) => key != 'api_key'),
        ),
      );
      if (statusResponse.statusCode == 200) {
        final status = HCustomerStatus.fromJson(json.decode(statusResponse.body));
        final zone = status.zones.singleWhere((z) => z.id == runZoneRequest.zoneId);
        await db.transaction((connection) async {
          final result = await connection.query(_updateZoneSql(customerId, zone));
          final map = result.single.toColumnMap();
          final runZoneResponse = RunZoneResponse(
            zone: Zone(
              id: runZoneRequest.zoneId,
              number: map['zone_num'],
              name: map['zone_name'],
              timeUntilNextRunSec: map['time_until_run_sec'],
              runLengthSec: map['run_length_sec'],
            ),
          );
          return Response.ok(
            jsonEncode(runZoneResponse),
          );
        });
      }
    }
    return Response(runResponse.statusCode, body: runResponse.body);
  }

  String _updateZoneSql(int customerId, HZone zone) => 'UPDATE zone '
      'SET time_until_run_sec = ${zone.secondsUntilNextRun}, run_length_sec = ${zone.lengthOfNextRunTimeOrTimeRemaining} '
      'WHERE zone_id = ${zone.id} AND customer_id = $customerId;';
}
