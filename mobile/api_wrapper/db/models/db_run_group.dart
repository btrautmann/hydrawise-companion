import 'package:postgres/postgres.dart';

class DbRunGroup {
  DbRunGroup({
    required this.id,
    required this.programId,
    required this.durationSeconds,
    required this.startHour,
    required this.startMinute,
    required this.lastRunTime,
  });

  factory DbRunGroup.fromPostGreSQLResultRow(PostgreSQLResultRow row) {
    final map = row.toColumnMap();
    return DbRunGroup(
      id: map['run_group_id'],
      programId: map['program_id'],
      durationSeconds: map['duration_sec'],
      startHour: map['start_hour'],
      startMinute: map['start_minute'],
      lastRunTime: map['last_run_time'],
    );
  }

  final int id;
  final int programId;
  final int durationSeconds;
  final int startHour;
  final int startMinute;
  final DateTime? lastRunTime;
}
