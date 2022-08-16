import 'dart:convert';

import 'package:api_models/api_models.dart';
import 'package:http/http.dart' as http;
import 'package:hydrawise/hydrawise.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';

import '../db/extensions/program.dart';
import '../db/queries/get_programs_by_customer_id.dart';
import '../db/queries/get_zone_by_id.dart';
import 'extensions.dart';

class RunZone {
  RunZone(this.db)
      : _getProgramsByCustomerId = GetProgramsByCustomerId(db),
        _getZoneById = GetZoneById(db);

  late final GetProgramsByCustomerId _getProgramsByCustomerId;
  late final GetZoneById _getZoneById;
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
        final hZone = status.zones.singleWhere((z) => z.id == runZoneRequest.zoneId);
        final dbZone = await _getZoneById(hZone.id);
        final programs = await _getProgramsByCustomerId(customerId);
        final nextRun = programs.nextRun(hZone.id);
        final runZoneResponse = RunZoneResponse(
          zone: Zone(
            id: dbZone!.id,
            number: dbZone.number,
            name: dbZone.name,
            isRunning: hZone.secondsUntilNextRun == 1,
            timeRemainingSec: hZone.lengthOfNextRunTimeOrTimeRemaining,
            nextRunStart: nextRun?.time.toString(),
            nextRunLengthSec: nextRun?.run.durationSec ?? 0,
          ),
        );
        return Response.ok(
          jsonEncode(runZoneResponse),
        );
      }
    }
    return Response(runResponse.statusCode, body: runResponse.body);
  }
}
