import 'package:postgres/postgres.dart';

class DbRun {
  DbRun({
    required this.id,
    required this.runGroupId,
    required this.zoneId,
    required this.lastRunTime,
  });

  factory DbRun.fromPostGreSQLResultRow(PostgreSQLResultRow row) {
    final map = row.toColumnMap();
    return DbRun(
      id: map['run_id'],
      runGroupId: map['run_group_id'],
      zoneId: map['zone_id'],
      lastRunTime: map['last_run_time'],
    );
  }

  final int id;
  final int runGroupId;
  final int zoneId;
  final DateTime? lastRunTime;
}
