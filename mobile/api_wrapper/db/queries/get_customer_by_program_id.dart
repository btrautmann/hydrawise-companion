import 'package:postgres/postgres.dart';

import '../../bin/utils/_postgresql_connection.dart';
import '../models/db_customer.dart';
import 'get_customer_by_id.dart';
import 'get_program_by_id.dart';

class GetCustomerByProgramId {
  GetCustomerByProgramId(this.db)
      : _getProgramById = GetProgramById(db),
        _getCustomerById = GetCustomerById(db);

  final PostgreSQLConnection Function() db;
  final GetProgramById _getProgramById;
  final GetCustomerById _getCustomerById;

  Future<DbCustomer> call(int programId) async {
    return db().use((connection) async {
      final program = await _getProgramById(programId);
      final customer = await _getCustomerById(program.customerId);

      return DbCustomer(
        id: customer.id,
        apiKey: customer.apiKey,
        activeControllerId: customer.activeControllerId,
      );
    });
  }
}
