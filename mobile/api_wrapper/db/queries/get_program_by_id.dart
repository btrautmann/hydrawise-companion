import 'package:postgres/postgres.dart';

import '../../bin/postgres_extensions.dart';
import '../models/db_program.dart';

class GetProgramById {
  GetProgramById(this.db);

  final PostgreSQLConnection Function() db;

  Future<DbProgram> call(int programId) async {
    return db().use((connection) async {
      final result = await connection.query(
        'SELECT * FROM program WHERE program_id=$programId LIMIT 1;',
      );
      return DbProgram.fromPostGreSQLResultRow(result.single);
    });
  }
}
