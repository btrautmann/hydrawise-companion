import 'package:postgres/postgres.dart';

import '../../bin/postgres_extensions.dart';
import '../models/db_run.dart';

class GetRunsByRunGroupId {
  GetRunsByRunGroupId(this.db);

  final PostgreSQLConnection Function() db;

  Future<List<DbRun>> call(int runGroupId) async {
    return db().use((connection) async {
      final result = await connection.query(
        'SELECT * from run WHERE run_group_id=$runGroupId;',
      );
      if (result.isEmpty) {
        return List.empty();
      }
      final runs = <DbRun>[];
      for (final row in result) {
        final map = row.toColumnMap();
        runs.add(
          DbRun(
            id: map['run_group_id'],
            lastRunTime: map['last_run_time'],
            runGroupId: runGroupId,
            zoneId: map['zone_id'],
          ),
        );
      }
      return runs;
    });
  }
}
