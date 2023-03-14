import 'package:postgres/postgres.dart';

import '../../bin/utils/_postgresql_connection.dart';
import '../models/db_customer.dart';
import '../models/db_program.dart';

class GetProgramsByCustomer {
  GetProgramsByCustomer(this.db);

  final PostgreSQLConnection Function() db;

  Future<List<DbProgram>> call(DbCustomer customer) async {
    return db().use((connection) async {
      final result = await connection.query(
        'SELECT * FROM program WHERE customer_id=${customer.id} AND controller_id=${customer.activeControllerId};',
      );
      return result.map(DbProgram.fromPostGreSQLResultRow).toList();
    });
  }
}
