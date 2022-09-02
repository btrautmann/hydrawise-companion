import 'package:postgres/postgres.dart';

import '../models/db_zone.dart';

class GetZoneById {
  GetZoneById(this.connection);

  final Future<PostgreSQLConnection> Function() connection;

  Future<DbZone?> call(int zoneId) async {
    final db = await connection();
    final result = await db.query('SELECT * from zone WHERE zone_id=$zoneId LIMIT 1;');
    if (result.isEmpty) {
      return null;
    }
    final map = result.single.toColumnMap();
    return DbZone(
      id: map['zone_id'],
      number: map['zone_num'],
      name: map['zone_name'],
    );
  }
}
