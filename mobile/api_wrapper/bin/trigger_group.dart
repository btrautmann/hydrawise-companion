import 'dart:convert';

import 'package:dotenv/dotenv.dart';
import 'package:http/http.dart' as client;
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';

import '../db/models/db_zone.dart';
import '../db/queries/get_run_group_by_id.dart';
import '../db/queries/get_runs_by_run_group_id.dart';
import '../db/queries/get_zone_by_id.dart';
import 'utils/_date_time.dart';
import 'utils/_postgresql_connection.dart';

class TriggerGroup {
  TriggerGroup(this.db, this.env)
      : _getRunGroupById = GetRunGroupById(db),
        _getRunsByRunGroupId = GetRunsByRunGroupId(db),
        _getZoneById = GetZoneById(db);

  final PostgreSQLConnection Function() db;
  final DotEnv env;
  final GetRunGroupById _getRunGroupById;
  final GetRunsByRunGroupId _getRunsByRunGroupId;
  final GetZoneById _getZoneById;

  Future<Response> call(Request request) async {
    final body = await request.readAsString();
    print('Received request to run group with body $body');
    final json = await jsonDecode(body) as Map<String, dynamic>;
    final runGroupId = json['run_group_id'] as int;
    final runGroup = await _getRunGroupById(runGroupId);
    final runs = await _getRunsByRunGroupId(runGroupId);
    // TODO(brandon): If creating the task fails, we should either consider rolling back
    // the transaction (not sure how) or adding retry logic. Otherwise the runs won't
    // actually trigger.
    // TODO(brandon): We'll need to delete/re-create tasks when updating a program, so
    // this should probably be pulled out into a callable function/use-case
    final zones = <DbZone>[];
    for (final run in runs) {
      final zone = await _getZoneById(run.zoneId);
      zones.add(zone);
    }
    // Sort run priority by zone number for now
    runs.sort(
      (a, b) => zones
          .singleWhere((z) => a.zoneId == z.id)
          .number
          .compareTo(zones.singleWhere((z) => b.zoneId == z.id).number),
    );
    Future<List<client.Response>> createRunTasks() async {
      final responses = <client.Response>[];
      for (var i = 0; i < runs.length; i++) {
        final delay = i * runGroup.durationSeconds;
        final response = await client.post(
          Uri.https(env['TASKS_API_END_POINT']!, '/api/v1/create'),
          body: jsonEncode(
            <String, dynamic>{
              'run_group_id': runGroupId,
              'run_id': runs[i].id,
              'endpoint': 'trigger_run',
              'delay': delay,
            },
          ),
        );
        responses.add(response);
      }
      return responses;
    }

    final responses = await createRunTasks();
    // TODO(brandon): Create task for the next *group* run.

    final failures = responses.where((r) => r.statusCode != 200);
    if (failures.isNotEmpty) {
      final firstFailure = failures.first;
      return Response(
        400,
        body: jsonEncode(
          <String, dynamic>{
            'message': 'Failed to create all tasks for $runGroupId',
            'statusCode': firstFailure.statusCode,
            'reason': firstFailure.reasonPhrase,
          },
        ),
        headers: {'Content-Type': 'application/json'},
      );
    } else {
      // TODO(brandon): To allow cancelation of runs once a run
      // group has started, we'll need to store the task id for
      // each
      await db().use((connection) async {
        await connection.query(
          _setRunGroupLastRunTimeSql(runGroupId, nowUtc()),
        );
      });
    }

    return Response.ok(
      jsonEncode(<String, dynamic>{'request_handled': true}),
      headers: {'Content-Type': 'application/json'},
    );
  }
}

String _setRunGroupLastRunTimeSql(int runGroupId, DateTime runTime) {
  return 'UPDATE run_group SET last_run_time = \'${runTime.toPostgreSQLTimestampFormat()}\' '
      'WHERE run_group_id=$runGroupId ';
}
