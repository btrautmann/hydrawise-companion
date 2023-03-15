import 'dart:convert';

import 'package:dotenv/dotenv.dart';
import 'package:http/http.dart' as client;
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';

import '../db/models/db_zone.dart';
import '../db/queries/get_next_run_for_run_group.dart';
import '../db/queries/get_run_group_by_id.dart';
import '../db/queries/get_runs_by_run_group_id.dart';
import '../db/queries/get_zone_by_id.dart';
import 'utils/_date_time.dart';
import 'utils/_postgresql_connection.dart';

class TriggerGroup {
  TriggerGroup(this.db, this.env)
      : _getRunGroupById = GetRunGroupById(db),
        _getRunsByRunGroupId = GetRunsByRunGroupId(db),
        _getNextRunForRunGroup = GetNextRunForRunGroup(db),
        _getZoneById = GetZoneById(db);

  final PostgreSQLConnection Function() db;
  final DotEnv env;
  final GetRunGroupById _getRunGroupById;
  final GetRunsByRunGroupId _getRunsByRunGroupId;
  final GetZoneById _getZoneById;
  final GetNextRunForRunGroup _getNextRunForRunGroup;

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

    Future<client.Response> createNextGroupTask() async {
      final now = nowUtc().copyWith(second: 0, millisecond: 0, microsecond: 0);
      final nextRunDateTime = await _getNextRunForRunGroup(group: runGroup);
      final delay = nextRunDateTime.difference(now).inMilliseconds;
      final secondsDelay = (delay / 1000).round();
      print('Delaying group task for ${runGroup.id} by $secondsDelay seconds');
      return client.post(
        Uri.https(env['TASKS_API_END_POINT']!, '/api/v1/create'),
        body: jsonEncode(
          <String, dynamic>{
            'run_group_id': runGroup.id,
            'endpoint': 'trigger_group',
            'delay': secondsDelay,
          },
        ),
      );
    }

    // TODO(brandon): To allow cancelation of runs once a run
    // group has started, we'll need to store the task id for
    // each
    // Create tasks that will trigger each run in this group
    final responses = await createRunTasks();
    responses.forEach(print);

    // TODO(brandon): To allow cancelation/skipping of a group, we'll
    // need to store the task id of the task we just created
    // Create the next task that will trigger this group to run again
    final response = await createNextGroupTask();
    print(response);

    await db().use((connection) async {
      await connection.query(
        _setRunGroupLastRunTimeSql(runGroupId, nowUtc()),
      );
    });

    return Response.ok(
      jsonEncode(<String, dynamic>{'request_handled': true}),
      headers: {'Content-Type': 'application/json'},
    );
  }
}

String _setRunGroupLastRunTimeSql(int runGroupId, DateTime runTime) {
  return 'UPDATE run_group SET last_run_time = \'${runTime.toPostgreSQLTimestampFormat()}\' '
      'WHERE run_group_id=$runGroupId;';
}
