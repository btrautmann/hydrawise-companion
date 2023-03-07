import 'package:postgres/postgres.dart';

import '../../bin/postgres_extensions.dart';
import '../models/db_run_group.dart';

class GetRunGroupsByProgramId {
  GetRunGroupsByProgramId(this.db);

  final PostgreSQLConnection Function() db;

  Future<List<DbRunGroup>> call(int programId) async {
    return db().use((connection) async {
      final result = await connection.query(
        'SELECT * from run_group WHERE program_id=$programId;',
      );
      if (result.isEmpty) {
        return List.empty();
      }
      final runGroups = <DbRunGroup>[];
      for (final row in result) {
        final map = row.toColumnMap();
        runGroups.add(
          DbRunGroup(
            id: map['run_group_id'],
            programId: map['program_id'],
            durationSeconds: map['duration_sec'],
            startHour: map['start_hour'],
            startMinute: map['start_minute'],
            lastRunTime: map['last_run_time'],
          ),
        );
      }
      return runGroups;
    });
  }
}
