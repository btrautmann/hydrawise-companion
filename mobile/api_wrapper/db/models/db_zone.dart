import 'package:postgres/postgres.dart';

class DbZone {
  DbZone({
    required this.id,
    required this.number,
    required this.name,
  });

  factory DbZone.fromPostGreSQLResultRow(PostgreSQLResultRow row) {
    final map = row.toColumnMap();
    return DbZone(
      id: map['zone_id'],
      number: map['zone_num'],
      name: map['zone_name'],
    );
  }

  final int id;
  final int number;
  final String name;
}
