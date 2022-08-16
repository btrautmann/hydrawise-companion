import 'dart:convert';

import 'package:api_models/api_models.dart';
import 'package:http/http.dart' as http;
import 'package:hydrawise/hydrawise.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';

import '../db/extensions/program.dart';
import '../db/mappings/db_customer.dart';
import '../db/queries/get_customer_by_id.dart';
import '../db/queries/get_programs_by_customer_id.dart';
import '../db/queries/get_zones_by_customer_id.dart';
import 'extensions.dart';

class GetCustomer {
  GetCustomer(this.db)
      : _getZonesByCustomerId = GetZonesByCustomerId(db),
        _getCustomerById = GetCustomerById(db),
        _getProgramsByCustomerId = GetProgramsByCustomerId(db);

  late final GetZonesByCustomerId _getZonesByCustomerId;
  late final GetCustomerById _getCustomerById;
  late final GetProgramsByCustomerId _getProgramsByCustomerId;

  final PostgreSQLConnection db;

  Future<Response> call(Request request) async {
    final customerId = request.customerId;

    final customer = await _getCustomerById(customerId);
    final zones = await _getZonesByCustomerId(customerId);
    final programs = await _getProgramsByCustomerId(customerId);

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

    return Response.ok(
      jsonEncode(
        GetCustomerResponse(
          customer: customer.toCustomer(),
          zones: zones
              .map(
                (z) => Zone(
                  id: z.id,
                  number: z.number,
                  name: z.name,
                  isRunning: status.zones.singleWhere((e) => e.id == z.id).secondsUntilNextRun == 1,
                  timeRemainingSec: status.zones.singleWhere((e) => e.id == z.id).lengthOfNextRunTimeOrTimeRemaining,
                  nextRunStart: programs.nextRun(z.id)?.time.toString(),
                  nextRunLengthSec: programs.nextRun(z.id)?.run.durationSec ?? 0,
                ),
              )
              .toList(),
        ),
      ),
      headers: {'Content-Type': 'application/json'},
    );
  }
}
