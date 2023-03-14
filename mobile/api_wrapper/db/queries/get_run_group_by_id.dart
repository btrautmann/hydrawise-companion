import 'package:postgres/postgres.dart';

import '../../bin/postgres_extensions.dart';
import '../models/db_run_group.dart';

class GetRunGroupById {
  GetRunGroupById(this.db);

  final PostgreSQLConnection Function() db;

  Future<DbRunGroup> call(int runGroupId) async {
    return db().use((connection) async {
      final result = await connection.query(
        'SELECT * from run_group WHERE run_group_id=$runGroupId LIMIT 1;',
      );
      return DbRunGroup.fromPostGreSQLResultRow(result.single);
    });
  }
}
