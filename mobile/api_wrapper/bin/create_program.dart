import 'dart:convert';

import 'package:api_models/api_models.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';

import 'extensions.dart';

class CreateProgram {
  CreateProgram(this.db);

  final PostgreSQLConnection db;

  Future<Response> call(Request request) async {
    final body = await request.readAsString();
    final createProgramRequest = CreateProgramRequest.fromJson(json.decode(body));

    final customerId = request.customerId;

    late final Program program;

    await db.transaction((connection) async {
      final insertProgramResult = await connection.query(
        _insertProgramSql(
          createProgramRequest,
          customerId,
        ),
      );
      print(insertProgramResult.affectedRowCount);
      final programId = insertProgramResult.single.toColumnMap()['program_id'] as int;
      final runs = <Run>[];
      for (final run in createProgramRequest.runs) {
        final insertRunResult = await connection.query(
          _insertRunSql(
            run,
            programId,
          ),
        );
        final runId = insertRunResult.single.toColumnMap()['run_id'] as int;
        runs.add(
          Run(
            id: runId,
            programId: programId,
            zoneId: run.zoneId,
            durationSeconds: run.durationSeconds,
            startHour: run.startHour,
            startMinute: run.startMinute,
          ),
        );
      }
      program = Program(
        id: programId,
        name: createProgramRequest.programName,
        frequency: createProgramRequest.frequency,
        runs: runs,
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
  }
}

String _insertProgramSql(
  CreateProgramRequest request,
  int customerId,
) =>
    'INSERT INTO program (customer_id, name, frequency) '
    'VALUES ($customerId, \'${request.programName}\', ARRAY${request.frequency.toString()}) '
    'RETURNING program_id;';

String _insertRunSql(RunCreation runCreation, int programId) =>
    'INSERT INTO run (program_id, zone_id, duration_sec, start_hour, start_minute) '
    'VALUES ($programId, ${runCreation.zoneId}, ${runCreation.durationSeconds}, ${runCreation.startHour}, ${runCreation.startMinute}) '
    'RETURNING run_id;';
