import 'dart:convert';

import 'package:api_models/api_models.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';

import 'postgres_extensions.dart';

class CheckRuns {
  CheckRuns(this.db);

  final PostgreSQLConnection Function() db;

  Future<Response> call(Request request) async {
    final runsToRun = <Run>[];
    return db().use((connection) async {
      await connection.transaction((connection) async {
        // First, get all programs intended to run today
        final programsResult = await connection.query(_getTodayProgramsSql());
        final programs = <Program>[];
        for (final row in programsResult) {
          final map = row.toColumnMap();
          final program = Program(
            id: map['program_id'],
            name: map['name'],
            frequency: map['frequency'],
            runs: List.empty(),
          );
          programs.add(program);
        }
        for (final program in programs) {
          final runsResult = await connection.query(_getRunsSql(program.id));
          for (final row in runsResult) {
            final map = row.toColumnMap();
            final run = Run(
              id: map['run_id'],
              programId: map['program_id'],
              zoneId: map['zone_id'],
              durationSeconds: map['duration_sec'],
              startHour: map['start_hour'],
              startMinute: map['start_minute'],
            );
            runsToRun.add(run);
          }
        }
      });
      return Response.ok(jsonEncode({'runCount': runsToRun.length}));
    });
  }
}

String _getRunsSql(int programId) => 'SELECT * FROM run WHERE program_id=$programId;';

String _getTodayProgramsSql() {
  // TODO(brandon): Need to adjust this to the timezone of customer
  final today = DateTime.now().weekday;
  return 'SELECT * FROM program WHERE $today=ANY(frequency)';
}
