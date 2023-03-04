import 'dart:convert';

import 'package:api_models/api_models.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';

import '../db/queries/get_customer_by_id.dart';
import 'extensions.dart';
import 'postgres_extensions.dart';

class CreateProgram {
  CreateProgram(this.db) : _getCustomerById = GetCustomerById(db);

  final PostgreSQLConnection Function() db;
  final GetCustomerById _getCustomerById;

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

        final now = DateTime.now();
        for (final runCreation in createProgramRequest.runs) {
          final insertRunGroupResult = await connection.query(
            _insertRunGroupSql(runCreation, programId, now),
          );
          final runGroupId = insertRunGroupResult.single.toColumnMap()['run_group_id'] as int;
          for (final zoneId in runCreation.zoneIds) {
            await connection.query(_insertRunSql(runGroupId, zoneId, now));
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

String _insertRunGroupSql(RunGroupCreation run, int programId, DateTime now) =>
    'INSERT INTO run_group (program_id, duration_sec, start_hour, start_minute) '
    'VALUES ($programId, ${run.durationSeconds}, ${run.startHour}, ${run.startMinute}) '
    'RETURNING run_group_id;';

String _insertRunSql(int runGroupId, int zoneId, DateTime now) => 'INSERT INTO run (run_group_id, zone_id) '
    'VALUES ($runGroupId, $zoneId) '
    'RETURNING run_id;';
