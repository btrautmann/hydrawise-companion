import 'dart:convert';

import 'package:api_models/api_models.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';

import '../db/queries/get_runs_by_run_group_id.dart';
import 'utils/_postgresql_connection.dart';
import 'utils/_request.dart';

class GetPrograms {
  GetPrograms(this.db) : _getRunsByRunGroupId = GetRunsByRunGroupId(db);

  final PostgreSQLConnection Function() db;
  final GetRunsByRunGroupId _getRunsByRunGroupId;

  Future<Response> call(Request request) async {
    final customerId = request.customerId;

    final programs = <Program>[];

    return db().use((connection) async {
      await connection.transaction((connection) async {
        final programsResult = await connection.query(_getProgramsSql(customerId));
        for (final row in programsResult) {
          final map = row.toColumnMap();
          final programId = map['program_id'] as int;
          final runGroupResult = await connection.query(_getRunGroupsSql(programId));
          final runs = <RunGroup>[];
          for (final row in runGroupResult) {
            final map = row.toColumnMap();
            final runGroupId = map['run_group_id'];
            final runsForRunGroup = await _getRunsByRunGroupId(runGroupId);
            runs.add(
              RunGroup(
                id: runGroupId,
                programId: programId,
                zoneIds: runsForRunGroup.map((r) => r.zoneId).toList(),
                startHour: map['start_hour'],
                startMinute: map['start_minute'],
                durationSeconds: map['duration_sec'],
                lastRunTime: map['last_run_time'],
              ),
            );
          }
          programs.add(
            Program(
              id: map['program_id'],
              name: map['name'],
              frequency: map['frequency'],
              runs: runs,
            ),
          );
        }
      });
      return Response.ok(
        jsonEncode(GetProgramsResponse(programs: programs)),
        headers: {'Content-Type': 'application/json'},
      );
    });
  }
}

String _getProgramsSql(int customerId) => 'SELECT * FROM program WHERE customer_id=$customerId;';

String _getRunGroupsSql(int programId) => 'SELECT * FROM run_group WHERE program_id=\'$programId\';';
