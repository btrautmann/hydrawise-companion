import 'package:postgres/postgres.dart';

import '../models/db_customer.dart';

class GetCustomerById {
  GetCustomerById(this.db);

  final PostgreSQLConnection db;

  Future<DbCustomer> call(int customerId) async {
    final result = await db.query('SELECT * FROM customer WHERE customer_id=$customerId LIMIT 1;');
    final map = result.single.toColumnMap();

    return DbCustomer(
      customerId: customerId,
      activeControllerId: map['active_controller_id'],
    );
  }
}
