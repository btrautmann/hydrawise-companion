import 'dart:convert';

import 'package:api_models/api_models.dart';
import 'package:http/http.dart' as http;
import 'package:hydrawise/hydrawise.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';

import '../db/extensions/program.dart';
import '../db/queries/get_customer_by_id.dart';
import '../db/queries/get_programs_by_customer.dart';
import '../db/queries/get_zone_by_id.dart';
import 'extensions.dart';

class StopZone {
  StopZone(this.db)
      : _getProgramsByCustomerId = GetProgramsByCustomer(db),
        _getZoneById = GetZoneById(db),
        _getCustomerById = GetCustomerById(db);

  final PostgreSQLConnection db;
  final GetCustomerById _getCustomerById;
  final GetZoneById _getZoneById;
  final GetProgramsByCustomer _getProgramsByCustomerId;

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
        final hZone = status.zones.singleWhere((z) => z.id == stopZoneRequest.zoneId);
        final dbZone = await _getZoneById(hZone.id);
        final customer = await _getCustomerById(customerId);
        final programs = await _getProgramsByCustomerId(customer);
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

    return Response(stopResponse.statusCode, body: stopResponse.body);
  }
}
