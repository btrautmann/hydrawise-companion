import 'package:postgres/postgres.dart';

import '../../bin/utils/_postgresql_connection.dart';
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
      return result.map(DbRun.fromPostGreSQLResultRow).toList();
    });
  }
}
