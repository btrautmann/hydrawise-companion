import 'package:postgres/postgres.dart';

class DbController {
  DbController({
    required this.id,
    required this.customerId,
    required this.timezone,
  });

  factory DbController.fromPostGreSQLResultRow(PostgreSQLResultRow row) {
    final map = row.toColumnMap();
    return DbController(
      id: map['controller_id'],
      customerId: map['customer_id'],
      timezone: map['timezone'],
    );
  }

  final int id;
  final int customerId;
  final String timezone;
}
