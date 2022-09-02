import 'package:hydrawise/hydrawise.dart';
import 'package:postgres/postgres.dart';

import '../../bin/postgres_extensions.dart';
import '../models/db_customer.dart';

class InsertCustomer {
  InsertCustomer(this.db);

  final PostgreSQLConnection Function() db;

  Future<DbCustomer> call({
    required String apiKey,
    required HCustomerDetails details,
    required HCustomerStatus status,
  }) async {
    final insertCustomerSql = 'INSERT INTO customer (customer_id, api_key, active_controller_id) '
        'VALUES (${details.customerId}, \'$apiKey\', ${details.activeControllerId}) '
        'ON CONFLICT (customer_id, api_key) DO NOTHING;';

    // For now, default to America/New_York for all controller timezones
    String insertControllerSql(HydrawiseController controller) =>
        'INSERT INTO controller (controller_id, customer_id, timezone) '
        'VALUES (${controller.id}, ${details.customerId}, \'America/New_York\') '
        'ON CONFLICT (controller_id, customer_id) DO NOTHING;';

    String insertZoneSql(HZone zone) => 'INSERT INTO zone (zone_id, customer_id, controller_id, zone_num, zone_name) '
        'VALUES (${zone.id}, ${details.customerId}, ${details.activeControllerId}, ${zone.physicalNumber}, \'${zone.name}\') '
        'ON CONFLICT (zone_id, customer_id, controller_id) DO NOTHING;';

    return db().use((connection) async {
      await connection.transaction((connection) async {
        await connection.query(insertCustomerSql);
        for (final controller in details.controllers) {
          await connection.query(insertControllerSql(controller));
        }
        for (final zone in status.zones) {
          await connection.query(insertZoneSql(zone));
        }
      });
      return DbCustomer(
        id: details.activeControllerId,
        activeControllerId: details.activeControllerId,
      );
    });
  }
}
