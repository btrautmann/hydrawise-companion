import 'package:postgres/postgres.dart';

class DbProgram {
  DbProgram({
    required this.id,
    required this.customerId,
    required this.controllerId,
    required this.name,
    required this.frequency,
  });

  factory DbProgram.fromPostGreSQLResultRow(PostgreSQLResultRow row) {
    final map = row.toColumnMap();
    return DbProgram(
      id: map['program_id'],
      customerId: map['customer_id'],
      controllerId: map['controller_id'],
      name: map['name'],
      frequency: map['frequency'],
    );
  }

  final int id;
  final int customerId;
  final int controllerId;
  final String name;
  final List<int> frequency;
}
