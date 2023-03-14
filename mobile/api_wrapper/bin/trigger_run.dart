import 'dart:convert';

import 'package:api_models/api_models.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';

import '../db/queries/get_customer_by_program_id.dart';
import '../db/queries/get_run_group_by_id.dart';
import '../db/queries/get_runs_by_run_group_id.dart';
import 'run_zone_internal.dart';

class TriggerRun {
  TriggerRun(this.db)
      : _getRunsByRunGroupId = GetRunsByRunGroupId(db),
        _getRunGroupById = GetRunGroupById(db),
        _getCustomerByProgramId = GetCustomerByProgramId(db);

  final PostgreSQLConnection Function() db;
  final GetRunsByRunGroupId _getRunsByRunGroupId;
  final GetRunGroupById _getRunGroupById;
  final GetCustomerByProgramId _getCustomerByProgramId;

  Future<Response> call(Request request) async {
    final body = await request.readAsString();
    print('Received request to run a run with body $body');
    final json = await jsonDecode(body) as Map<String, dynamic>;
    final runGroupId = json['run_group_id'] as int;
    final runId = json['run_id'] as int;
    final runs = await _getRunsByRunGroupId(runGroupId);
    final run = runs.singleWhere((r) => r.id == runId);
    final runGroup = await _getRunGroupById(runGroupId);
    final zoneId = run.zoneId;
    final runDuration = runGroup.durationSeconds;
    final customer = await _getCustomerByProgramId(runGroup.programId);

    print('Requesting Hydrawise to run $zoneId for $runDuration seconds');
    final response = await runZone(
      request: RunZoneRequest(
        zoneId: zoneId,
        runLengthSeconds: runDuration,
      ),
      apiKey: customer.apiKey,
    );

    if (response.statusCode != 200) {
      print('Request failed: ${response.body}');
    }

    return Response(
      response.statusCode,
      headers: {'Content-Type': 'application/json'},
    );
  }
}
