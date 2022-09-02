import 'package:postgres/postgres.dart';

import '../models/db_customer.dart';

class GetCustomerById {
  GetCustomerById(this.connection);

  final Future<PostgreSQLConnection> Function() connection;

  Future<DbCustomer> call(int customerId) async {
    final db = await connection();
    final result = await db.query('SELECT * FROM customer WHERE customer_id=$customerId LIMIT 1;');
    final map = result.single.toColumnMap();

    return DbCustomer(
      id: customerId,
      activeControllerId: map['active_controller_id'],
    );
  }
}
