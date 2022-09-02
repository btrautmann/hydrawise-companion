import 'package:postgres/postgres.dart';

import '../models/db_controller.dart';

class GetControllerById {
  GetControllerById(this.connection);

  final Future<PostgreSQLConnection> Function() connection;

  Future<DbController> call(int controllerId) async {
    final db = await connection();
    final result = await db.query('SELECT * FROM controller WHERE controller_id=$controllerId LIMIT 1;');
    final map = result.single.toColumnMap();

    return DbController(
      id: map['controller_id'],
      customerId: map['customer_id'],
      timezone: map['timezone'],
    );
  }
}
