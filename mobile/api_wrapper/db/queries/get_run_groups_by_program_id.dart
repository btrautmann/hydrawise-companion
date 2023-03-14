import 'package:postgres/postgres.dart';

import '../../bin/utils/_postgresql_connection.dart';
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
      return result.map(DbRunGroup.fromPostGreSQLResultRow).toList();
    });
  }
}
