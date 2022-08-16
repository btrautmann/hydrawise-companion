import 'package:postgres/postgres.dart';

import '../models/db_customer.dart';
import '../models/db_zone.dart';

class GetZonesByCustomer {
  GetZonesByCustomer(this.db);

  final PostgreSQLConnection db;

  Future<List<DbZone>> call(DbCustomer customer) async {
    final result = await db.query('SELECT * from zone WHERE customer_id=${customer.customerId} AND controller_id=${customer.activeControllerId};');
    final zones = <DbZone>[];
    for (final row in result) {
      final map = row.toColumnMap();
      zones.add(
        DbZone(
          id: map['zone_id'],
          number: map['zone_num'],
          name: map['zone_name'],
        ),
      );
    }
    return zones;
  }
}