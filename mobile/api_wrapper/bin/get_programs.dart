import 'dart:convert';

import 'package:api_models/api_models.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';

import 'extensions.dart';

class GetPrograms {
  GetPrograms(this.connection);

  final Future<PostgreSQLConnection> Function() connection;

  Future<Response> call(Request request) async {
    final db = await connection();
    final customerId = request.customerId;

    final programs = <Program>[];

    await db.transaction((connection) async {
      final programsResult = await connection.query(_getProgramsSql(customerId));
      for (final row in programsResult) {
        final map = row.toColumnMap();
        final programId = map['program_id'] as int;
        final runsResult = await connection.query(_getRunsSql(programId));
        final runs = <Run>[];
        for (final row in runsResult) {
          final map = row.toColumnMap();
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
  }
}

String _getProgramsSql(int customerId) => 'SELECT * FROM program WHERE customer_id=$customerId;';

String _getRunsSql(int programId) => 'SELECT * FROM run WHERE program_id=\'$programId\';';
