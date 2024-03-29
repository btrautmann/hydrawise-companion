import 'dart:convert';

import 'package:api_models/api_models.dart';
import 'package:dotenv/dotenv.dart';
import 'package:http/http.dart' as client;
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';

import '../db/queries/get_customer_by_id.dart';
import '../db/queries/get_next_run_for_run_group.dart';
import '../db/queries/get_run_group_by_id.dart';
import 'utils/_date_time.dart';
import 'utils/_postgresql_connection.dart';
import 'utils/_request.dart';

class CreateProgram {
  CreateProgram(this.db, this.env)
      : _getRunGroupById = GetRunGroupById(db),
        _getCustomerById = GetCustomerById(db),
        _getNextRunForRunGroup = GetNextRunForRunGroup(db);

  final PostgreSQLConnection Function() db;
  final GetRunGroupById _getRunGroupById;
  final GetCustomerById _getCustomerById;
  final GetNextRunForRunGroup _getNextRunForRunGroup;
  final DotEnv env;

  Future<Response> call(Request request) async {
    final body = await request.readAsString();
    final createProgramRequest = CreateProgramRequest.fromJson(json.decode(body));

    final customerId = request.customerId;

    late final Program program;

    final customer = await _getCustomerById(customerId);
    return db().use((connection) async {
      await connection.transaction((connection) async {
        final insertProgramResult = await connection.query(
          _insertProgramSql(
            createProgramRequest,
            customerId,
            customer.activeControllerId,
          ),
        );
        final programId = insertProgramResult.single.toColumnMap()['program_id'] as int;
        final outputRuns = <RunGroup>[];

        for (final runCreation in createProgramRequest.runs) {
          final insertRunGroupResult = await connection.query(
            _insertRunGroupSql(runCreation, programId),
          );
          final runGroupId = insertRunGroupResult.single.toColumnMap()['run_group_id'] as int;
          for (final zoneId in runCreation.zoneIds) {
            await connection.query(_insertRunSql(runGroupId, zoneId));
          }

          outputRuns.add(
            RunGroup(
              id: runGroupId,
              programId: programId,
              zoneIds: runCreation.zoneIds,
              durationSeconds: runCreation.durationSeconds,
              startHour: runCreation.startHour,
              startMinute: runCreation.startMinute,
            ),
          );
        }
        program = Program(
          id: programId,
          name: createProgramRequest.programName,
          frequency: createProgramRequest.frequency,
          runs: outputRuns,
        );
      });

      // TODO(brandon): If creating the task fails, we should either consider rolling back
      // the transaction (not sure how) or adding retry logic. Otherwise the runs won't
      // actually trigger.
      // TODO(brandon): We'll need to delete/re-create tasks when updating a program, so
      // this should probably be pulled out into a callable function/use-case
      Future<Map<RunGroup, client.Response>> createRunGroupTasks() async {
        final now = nowUtc().copyWith(second: 0, millisecond: 0, microsecond: 0);
        print('Current time (during task creation) is $now');
        final responses = <RunGroup, client.Response>{};
        for (final run in program.runs) {
          final dbRunGroup = await _getRunGroupById(run.id);
          final nextRunDateTime = await _getNextRunForRunGroup(group: dbRunGroup);
          final delay = nextRunDateTime.difference(now).inMilliseconds;
          final secondsDelay = (delay / 1000).round();
          print('Delaying group task for ${run.id} by $secondsDelay seconds');
          final response = await client.post(
            Uri.https(env['TASKS_API_END_POINT']!, '/api/v1/create'),
            body: jsonEncode(
              <String, dynamic>{
                'run_group_id': run.id,
                'endpoint': 'trigger_group',
                'delay': secondsDelay,
              },
            ),
          );
          responses[run] = response;
        }
        return responses;
      }

      final responses = await createRunGroupTasks();
      for (final r in responses.values) {
        final body = r.body;
        print(body);
      }

      return Response.ok(
        jsonEncode(
          CreateProgramResponse(
            program: program,
          ),
        ),
        headers: {'Content-Type': 'application/json'},
      );
    });
  }
}

String _insertProgramSql(
  CreateProgramRequest request,
  int customerId,
  int controllerId,
) =>
    'INSERT INTO program (customer_id, name, frequency, controller_id) '
    'VALUES ($customerId, \'${request.programName}\', ARRAY${request.frequency}, $controllerId) '
    'RETURNING program_id;';

String _insertRunGroupSql(RunGroupCreation run, int programId) =>
    'INSERT INTO run_group (program_id, duration_sec, start_hour, start_minute) '
    'VALUES ($programId, ${run.durationSeconds}, ${run.startHour}, ${run.startMinute}) '
    'RETURNING run_group_id;';

String _insertRunSql(int runGroupId, int zoneId) => 'INSERT INTO run (run_group_id, zone_id) '
    'VALUES ($runGroupId, $zoneId) '
    'RETURNING run_id;';
