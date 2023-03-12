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
      final map = result.single.toColumnMap();

      return DbProgram(
        id: map['program_id'],
        customerId: map['customer_id'],
        name: map['name'],
        frequency: map['frequency'],
      );
    });
  }
}
