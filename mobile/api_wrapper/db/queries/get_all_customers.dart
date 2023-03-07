import 'package:postgres/postgres.dart';

import '../../bin/postgres_extensions.dart';
import '../models/db_customer.dart';

class GetAllCustomers {
  GetAllCustomers(this.db);

  final PostgreSQLConnection Function() db;

  Future<List<DbCustomer>> call() async {
    return db().use((connection) async {
      final result = await connection.query(
        'SELECT * FROM customer;',
      );
      final customers = <DbCustomer>[];
      for (final row in result) {
        final map = row.toColumnMap();
        customers.add(
          DbCustomer(
            id: map['customer_id'],
            apiKey: map['api_key'],
            activeControllerId: map['active_controller_id'],
          ),
        );
      }
      return customers;
    });
  }
}
