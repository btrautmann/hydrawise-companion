import 'package:postgres/postgres.dart';

import '../../bin/postgres_extensions.dart';
import '../models/db_controller.dart';

class GetControllerById {
  GetControllerById(this.db);

  final PostgreSQLConnection Function() db;

  Future<DbController> call(int controllerId) async {
    return db().use((connection) async {
      final result = await connection.query(
        'SELECT * FROM controller WHERE controller_id=$controllerId LIMIT 1;',
      );
      final map = result.single.toColumnMap();

      return DbController(
        id: map['controller_id'],
        customerId: map['customer_id'],
        timezone: map['timezone'],
      );
    });
  }
}