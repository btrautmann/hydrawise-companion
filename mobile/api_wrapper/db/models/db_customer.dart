import 'package:api_models/api_models.dart';
import 'package:postgres/postgres.dart';

class DbCustomer {
  DbCustomer({
    required this.id,
    required this.apiKey,
    required this.activeControllerId,
  });

  factory DbCustomer.fromPostGreSQLResultRow(PostgreSQLResultRow row) {
    final map = row.toColumnMap();
    return DbCustomer(
      id: map['customer_id'],
      apiKey: map['api_key'],
      activeControllerId: map['active_controller_id'],
    );
  }

  final int id;
  final int activeControllerId;
  final String apiKey;
}

extension DbCustomerX on DbCustomer {
  Customer toCustomer() => Customer(
        customerId: id,
        activeControllerId: activeControllerId,
      );
}
