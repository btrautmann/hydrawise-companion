import 'package:postgres/postgres.dart';

import '../../bin/utils/_postgresql_connection.dart';
import '../models/db_customer.dart';
import '../models/db_zone.dart';

class GetZonesByCustomer {
  GetZonesByCustomer(this.db);

  final PostgreSQLConnection Function() db;

  Future<List<DbZone>> call(DbCustomer customer) async {
    return db().use((connection) async {
      final result = await connection.query(
        'SELECT * from zone WHERE customer_id=${customer.id} AND controller_id=${customer.activeControllerId};',
      );
      return result.map(DbZone.fromPostGreSQLResultRow).toList();
    });
  }
}
