import 'package:postgres/postgres.dart';

import '../../bin/postgres_extensions.dart';
import '../models/db_controller.dart';

class GetControllersByCustomerId {
  GetControllersByCustomerId(this.db);

  final PostgreSQLConnection Function() db;

  Future<List<DbController>> call(int customerId) async {
    return db().use((connection) async {
      final result = await connection.query(
        'SELECT * from controller WHERE customer_id=$customerId;',
      );
      final controllers = <DbController>[];
      for (final row in result) {
        final map = row.toColumnMap();
        controllers.add(
          DbController(
            id: map['controller_id'],
            customerId: customerId,
            timezone: map['timezone'],
          ),
        );
      }
      return controllers;
    });
  }
}
