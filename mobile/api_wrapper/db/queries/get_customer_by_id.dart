import 'package:postgres/postgres.dart';

import '../../bin/postgres_extensions.dart';
import '../models/db_customer.dart';

class GetCustomerById {
  GetCustomerById(this.db);

  final PostgreSQLConnection Function() db;

  Future<DbCustomer> call(int customerId) async {
    return db().use((connection) async {
      final result = await connection.query(
        'SELECT * FROM customer WHERE customer_id=$customerId LIMIT 1;',
      );
      return DbCustomer.fromPostGreSQLResultRow(result.single);
    });
  }
}
