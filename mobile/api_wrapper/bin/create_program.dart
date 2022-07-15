import 'dart:convert';

import 'package:api_models/api_models.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
import 'package:uuid/uuid.dart';

class CreateProgram {
  CreateProgram(this.db);

  final PostgreSQLConnection db;

  Future<Response> call(Request request) async {
    final body = await request.readAsString();
    final createProgramRequest =
        CreateProgramRequest.fromJson(json.decode(body));

    // TODO(brandon): Auth interception
    final queryResults =
        await db.query(_findCustomerSql(createProgramRequest.apiKey));
    if (queryResults.isEmpty) {
      return Response(401);
    }
    final customerId = queryResults.single.toColumnMap()['customer_id'] as int?;
    if (customerId == null) {
      return Response(401);
    }

    late final Program program;

    await db.transaction((connection) async {
      final programId = const Uuid().v4();
      final sql = _insertProgramSql(
        createProgramRequest,
        programId,
        customerId,
      );
      await connection.execute(sql);
      final runs = <Run>[];
      for (final run in createProgramRequest.runs) {
        final runId = const Uuid().v4();
        await connection.execute(
          _insertRunSql(
            run,
            programId,
            runId,
          ),
        );
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

String _findCustomerSql(String apiKey) =>
    'SELECT * FROM customer WHERE api_key=\'$apiKey\' LIMIT 1;';

String _insertProgramSql(
  CreateProgramRequest request,
  String programId,
  int customerId,
) =>
    'INSERT INTO program (program_id, customer_id, name, frequency) '
    'VALUES (\'$programId\', $customerId, \'${request.programName}\', ARRAY${request.frequency.toString()});';

String _insertRunSql(RunCreation runCreation, String programId, String runId) =>
    'INSERT INTO run (program_id, run_id, zone_id, duration_sec, start_hour, start_minute) '
    'VALUES (\'$programId\',\'$runId\', ${runCreation.zoneId}, ${runCreation.durationSeconds}, ${runCreation.startHour}, ${runCreation.startMinute});';
