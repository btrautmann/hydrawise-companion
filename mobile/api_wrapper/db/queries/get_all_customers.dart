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
      return result.map(DbCustomer.fromPostGreSQLResultRow).toList();
    });
  }
}
