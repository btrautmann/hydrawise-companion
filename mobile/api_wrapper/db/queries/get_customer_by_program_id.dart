import 'package:postgres/postgres.dart';

import '../../bin/postgres_extensions.dart';
import '../models/db_customer.dart';
import '../models/db_program.dart';
import 'get_customer_by_id.dart';

class GetCustomerByProgramId {
  GetCustomerByProgramId(this.db) : _getCustomerById = GetCustomerById(db);

  final PostgreSQLConnection Function() db;
  final GetCustomerById _getCustomerById;

  Future<DbCustomer> call(int programId) async {
    return db().use((connection) async {
      final result = await connection.query(
        'SELECT * FROM program WHERE program_id=$programId} LIMIT 1;',
      );
      final map = result.single.toColumnMap();
      final program = DbProgram(
        id: map['program_id'],
        customerId: map['customer_id'],
        name: map['name'],
        frequency: map['frequency'],
      );
      final customer = await _getCustomerById(program.customerId);

      return DbCustomer(
        id: customer.id,
        apiKey: customer.apiKey,
        activeControllerId: customer.activeControllerId,
      );
    });
  }
}
