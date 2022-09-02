import 'dart:convert';

import 'package:api_models/api_models.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';

import 'extensions.dart';
import 'postgres_extensions.dart';

class UpdateProgram {
  UpdateProgram(this.db);

  final PostgreSQLConnection Function() db;

  Future<Response> call(Request request) async {
    final body = await request.readAsString();
    final updateProgramRequest = UpdateProgramRequest.fromJson(
      json.decode(body),
    );

    final customerId = request.customerId;

    late final Program updatedProgram;
    final resultingRuns = <Run>[];
    return db().use((connection) async {
      await connection.transaction(
        (connection) async {
          await connection.query(
            _updateProgramSql(
              updateProgramRequest,
              customerId,
            ),
          );

          final originalRuns = <Run>[];
          final runsResult = await connection.query(
            _getRunsSql(
              updateProgramRequest.programId,
            ),
          );
          for (final row in runsResult) {
            final map = row.toColumnMap();
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
          // For ease, delete all existing runs
          for (final run in originalRuns) {
            await connection.query(_deleteRunSql(run.id));
          }
          for (final run in updateProgramRequest.runs) {
            final insertResult = await connection.query(
              _insertRunSql(run, updateProgramRequest.programId),
            );
            resultingRuns.add(
              Run(
                id: insertResult.single.toColumnMap()['run_id'] as int,
                programId: updateProgramRequest.programId,
                zoneId: run.zoneId,
                durationSeconds: run.durationSeconds,
                startHour: run.startHour,
                startMinute: run.startMinute,
              ),
            );
          }

          updatedProgram = Program(
            id: updateProgramRequest.programId,
            name: updateProgramRequest.programName,
            frequency: updateProgramRequest.frequency,
            runs: resultingRuns,
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
    });
  }
}

String _updateProgramSql(
  UpdateProgramRequest request,
  int customerId,
) =>
    'UPDATE program '
    'SET name = \'${request.programName}\', frequency=ARRAY${request.frequency.toString()} '
    'WHERE program_id = \'${request.programId}\';';

String _getRunsSql(int programId) => 'SELECT * FROM run WHERE program_id=$programId;';

String _deleteRunSql(int runId) => 'DELETE FROM run WHERE run_id=$runId;';

String _insertRunSql(RunCreation runCreation, int programId) =>
    'INSERT INTO run (program_id, zone_id, duration_sec, start_hour, start_minute) '
    'VALUES ($programId, ${runCreation.zoneId}, ${runCreation.durationSeconds}, ${runCreation.startHour}, ${runCreation.startMinute}) '
    'RETURNING run_id;';
