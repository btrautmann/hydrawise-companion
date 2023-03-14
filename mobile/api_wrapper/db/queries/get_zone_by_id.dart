import 'package:postgres/postgres.dart';

import '../../bin/utils/_postgresql_connection.dart';
import '../models/db_zone.dart';

class GetZoneById {
  GetZoneById(this.db);

  final PostgreSQLConnection Function() db;

  Future<DbZone?> call(int zoneId) async {
    return db().use((connection) async {
      final result = await connection.query(
        'SELECT * from zone WHERE zone_id=$zoneId LIMIT 1;',
      );
      if (result.isEmpty) {
        return null;
      }
      return DbZone.fromPostGreSQLResultRow(result.single);
    });
  }
}
