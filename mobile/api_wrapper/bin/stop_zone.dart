import 'dart:convert';

import 'package:api_models/api_models.dart';
import 'package:http/http.dart' as client;
import 'package:hydrawise/hydrawise.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';

import '../db/queries/get_customer_by_id.dart';
import '../db/queries/get_next_run_for_zone.dart';
import '../db/queries/get_programs_by_customer.dart';
import '../db/queries/get_zone_by_id.dart';
import 'utils/_request.dart';

class StopZone {
  StopZone(PostgreSQLConnection Function() db)
      : _getProgramsByCustomerId = GetProgramsByCustomer(db),
        _getNextRunForZone = GetNextRunForZone(db),
        _getZoneById = GetZoneById(db),
        _getCustomerById = GetCustomerById(db);

  final GetCustomerById _getCustomerById;
  final GetZoneById _getZoneById;
  final GetProgramsByCustomer _getProgramsByCustomerId;
  final GetNextRunForZone _getNextRunForZone;

  Future<Response> call(Request request) async {
    final body = await request.readAsString();
    final stopZoneRequest = StopZoneRequest.fromJson(json.decode(body));

    final customerId = request.customerId;

    final queryParameters = <String, String>{
      'api_key': request.apiKey,
      'action': 'stop',
      'relay_id': stopZoneRequest.zoneId.toString(),
    };

    final stopResponse = await client.get(
      Uri.http(
        'api.hydrawise.com',
        '/api/v1/setzone.php',
        queryParameters,
      ),
    );

    if (stopResponse.statusCode == 200) {
      final statusResponse = await client.get(
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
        final nextRun = await _getNextRunForZone(
          customer: customer,
          zone: dbZone,
          programs: programs,
        );
        final runZoneResponse = RunZoneResponse(
          zone: Zone(
            id: dbZone.id,
            number: dbZone.number,
            name: dbZone.name,
            isRunning: hZone.secondsUntilNextRun == 1,
            timeRemainingSec: hZone.lengthOfNextRunTimeOrTimeRemaining,
            nextRunStart: nextRun?.time.toString(),
            nextRunLengthSec: nextRun?.duration.inSeconds ?? 0,
          ),
        );
        return Response.ok(
          jsonEncode(runZoneResponse),
          headers: {'Content-Type': 'application/json'},
        );
      }
    }
    print(stopResponse.body);
    return Response(
      stopResponse.statusCode,
      body: jsonEncode(stopResponse.body),
      headers: {'Content-Type': 'application/json'},
    );
  }
}
