import 'dart:convert';

import 'package:api_models/api_models.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
import 'package:uuid/uuid.dart';

class UpdateProgram {
  UpdateProgram(this.db);

  final PostgreSQLConnection db;

  Future<Response> call(Request request) async {
    final body = await request.readAsString();
    final updateProgramRequest = UpdateProgramRequest.fromJson(json.decode(body));

    // TODO(brandon): Auth interception
    final queryResults = await db.query(_findCustomerSql(updateProgramRequest.apiKey));
    if (queryResults.isEmpty) {
      return Response(401);
    }
    final customerId = queryResults.single.toColumnMap()['customer_id'] as int?;
    if (customerId == null) {
      return Response(401);
    }

    late final Program updatedProgram;
    await db.transaction(
      (connection) async {
        await connection.execute(_updateProgramSql(updateProgramRequest, customerId));

        final originalRuns = <Run>[];
        final runsResult = await connection.query(_getRunsSql(updateProgramRequest.programId));
        for (final rResult in runsResult) {
          final map = rResult.toColumnMap();
          originalRuns.add(
            Run(
              id: map['run_id'],
              programId: map['program_id'],
              zoneId: map['zone_id'],
              durationSeconds: map['duration_sec'],
              startHour: map['start_hour'],
              startMinute: map['start_minute'],
            ),
          );
        }
        final runsToDelete = originalRuns.where(
          (run) => updateProgramRequest.runsToUpdate.every((other) => other.id != run.id),
        );
        print('Deleting $runsToDelete');
        for (final run in runsToDelete) {
          await connection.execute(_deleteRunSql(run.id));
        }
        for (final run in updateProgramRequest.runsToUpdate) {
          await connection.execute(_updateRunSql(run));
        }
        for (final run in updateProgramRequest.runsToCreate) {
          final runId = const Uuid().v4();
          await connection.execute(_insertRunSql(run, updateProgramRequest.programId, runId));
        }

        // Refetch runs because once we auto-increment ID we will need to anyway
        final newRunsResult = await connection.query(_getRunsSql(updateProgramRequest.programId));
        final runs = <Run>[];
        for (final rResult in newRunsResult) {
          final map = rResult.toColumnMap();
          runs.add(
            Run(
              id: map['run_id'],
              programId: map['program_id'],
              zoneId: map['zone_id'],
              durationSeconds: map['duration_sec'],
              startHour: map['start_hour'],
              startMinute: map['start_minute'],
            ),
          );
        }
        updatedProgram = Program(
          id: updateProgramRequest.programId,
          name: updateProgramRequest.programName,
          frequency: updateProgramRequest.frequency,
          runs: runs,
        );
      },
    );

    return Response.ok(
      jsonEncode(
        UpdateProgramResponse(
          program: updatedProgram,
        ),
      ),
      headers: {'Content-Type': 'application/json'},
    );
  }
}

String _findCustomerSql(String apiKey) => 'SELECT * FROM customer WHERE api_key=\'$apiKey\' LIMIT 1;';

String _updateProgramSql(
  UpdateProgramRequest request,
  int customerId,
) =>
    'UPDATE program '
    'SET name = \'${request.programName}\', frequency=ARRAY${request.frequency.toString()} '
    'WHERE program_id = \'${request.programId}\';';

String _getRunsSql(String programId) => 'SELECT * FROM run WHERE program_id=\'$programId\';';

String _deleteRunSql(String runId) => 'DELETE FROM run WHERE run_id=\'$runId\';';

String _updateRunSql(Run run) => 'UPDATE run '
    'SET zone_id = ${run.zoneId}, duration_sec=${run.durationSeconds}, start_hour=${run.startHour}, start_minute=${run.startMinute} '
    'WHERE run_id = \'${run.id}\';';

String _insertRunSql(RunCreation runCreation, String programId, String runId) =>
    'INSERT INTO run (program_id, run_id, zone_id, duration_sec, start_hour, start_minute) '
    'VALUES (\'$programId\',\'$runId\', ${runCreation.zoneId}, ${runCreation.durationSeconds}, ${runCreation.startHour}, ${runCreation.startMinute});';
