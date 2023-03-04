import 'dart:convert';

import 'package:api_models/api_models.dart';
import 'package:http/http.dart' as http;
import 'package:hydrawise/hydrawise.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';

import '../db/mappings/db_customer.dart';
import '../db/queries/get_customer_by_id.dart';
import '../db/queries/get_next_run_for_zone.dart';
import '../db/queries/get_programs_by_customer.dart';
import '../db/queries/get_zones_by_customer.dart';
import 'extensions.dart';

class GetCustomer {
  GetCustomer(this.db)
      : _getZonesByCustomer = GetZonesByCustomer(db),
        _getCustomerById = GetCustomerById(db),
        _getProgramsByCustomer = GetProgramsByCustomer(db),
        _getNextRunForZone = GetNextRunForZone(db);

  final PostgreSQLConnection Function() db;
  final GetNextRunForZone _getNextRunForZone;
  final GetZonesByCustomer _getZonesByCustomer;
  final GetCustomerById _getCustomerById;
  final GetProgramsByCustomer _getProgramsByCustomer;

  Future<Response> call(Request request) async {
    final customerId = request.customerId;

    final customer = await _getCustomerById(customerId);
    final zones = await _getZonesByCustomer(customer);
    final programs = await _getProgramsByCustomer(customer);

    final statusResponse = await http.get(
      Uri.http(
        'api.hydrawise.com',
        '/api/v1/statusschedule.php',
        <String, dynamic>{
          'api_key': request.apiKey,
        },
      ),
    );

    if (statusResponse.statusCode != 200) {
      return Response(statusResponse.statusCode, body: statusResponse.body);
    }
    final status = HCustomerStatus.fromJson(json.decode(statusResponse.body));
    final mappedZones = zones.map(
      (z) async {
        final nextRun = await _getNextRunForZone(
          customer: customer,
          zone: z,
          programs: programs,
        );
        return Zone(
          id: z.id,
          number: z.number,
          name: z.name,
          isRunning: status.zones.singleWhere((e) => e.id == z.id).secondsUntilNextRun == 1,
          timeRemainingSec: status.zones.singleWhere((e) => e.id == z.id).lengthOfNextRunTimeOrTimeRemaining,
          nextRunStart: nextRun?.time.toString(),
          nextRunLengthSec: nextRun?.duration.inSeconds ?? 0,
        );
      },
    ).toList();

    return Response.ok(
      jsonEncode(
        GetCustomerResponse(
          customer: customer.toCustomer(),
          zones: await Future.wait(mappedZones),
        ),
      ),
      headers: {'Content-Type': 'application/json'},
    );
  }
}
