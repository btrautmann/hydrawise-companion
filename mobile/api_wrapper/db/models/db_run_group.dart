class DbRunGroup {
  DbRunGroup({
    required this.id,
    required this.programId,
    required this.durationSeconds,
    required this.startHour,
    required this.startMinute,
    required this.lastRunTime,
  });

  final int id;
  final int programId;
  final int durationSeconds;
  final int startHour;
  final int startMinute;
  final DateTime lastRunTime;
}
