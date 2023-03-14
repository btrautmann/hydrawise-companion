import 'dart:convert';

import 'package:api_models/api_models.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';

import '../db/models/db_run_group.dart';
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
    final outputRuns = <RunGroup>[];
    return db().use((connection) async {
      await connection.transaction((connection) async {
        await connection.query(_updateProgramSql(updateProgramRequest, customerId));

        final originalRunGroups = <DbRunGroup>[];
        final runGroupsResult = await connection.query(
          _getRunGroupsSql(updateProgramRequest.programId),
        );
        for (final row in runGroupsResult) {
          originalRunGroups.add(DbRunGroup.fromPostGreSQLResultRow(row));
        }

        final now = DateTime.now();

        // For ease, delete all existing run groups (and associated runs)
        for (final run in originalRunGroups) {
          await connection.query(_deleteRunGroupSql(run.id));
        }
        for (final runCreation in updateProgramRequest.runs) {
          final insertRunGroupResult = await connection.query(
            _insertRunGroupSql(runCreation, updateProgramRequest.programId, now),
          );
          final runGroupId = insertRunGroupResult.single.toColumnMap()['run_group_id'] as int;
          for (final zoneId in runCreation.zoneIds) {
            await connection.query(_insertRunSql(runGroupId, zoneId, now));
          }

          outputRuns.add(
            RunGroup(
              id: runGroupId,
              programId: updateProgramRequest.programId,
              zoneIds: runCreation.zoneIds,
              durationSeconds: runCreation.durationSeconds,
              startHour: runCreation.startHour,
              startMinute: runCreation.startMinute,
            ),
          );
        }

        updatedProgram = Program(
          id: updateProgramRequest.programId,
          name: updateProgramRequest.programName,
          frequency: updateProgramRequest.frequency,
          runs: outputRuns,
        );
      });

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
    'SET name = \'${request.programName}\', frequency=ARRAY${request.frequency} '
    'WHERE program_id = \'${request.programId}\';';

String _getRunGroupsSql(int programId) => 'SELECT * FROM run_group WHERE program_id=$programId;';

String _deleteRunGroupSql(int runGroupId) => 'DELETE FROM run_group WHERE run_group_id=$runGroupId;';

String _insertRunGroupSql(RunGroupCreation run, int programId, DateTime now) =>
    'INSERT INTO run_group (program_id, duration_sec, start_hour, start_minute) '
    'VALUES ($programId, ${run.durationSeconds}, ${run.startHour}, ${run.startMinute}) '
    'RETURNING run_group_id;';

String _insertRunSql(int runGroupId, int zoneId, DateTime now) => 'INSERT INTO run (run_group_id, zone_id) '
    'VALUES ($runGroupId, $zoneId) '
    'RETURNING run_id;';
