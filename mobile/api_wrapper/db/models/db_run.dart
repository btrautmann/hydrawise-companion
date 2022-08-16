class DbRun {
  DbRun({
    required this.id,
    required this.programId,
    required this.zoneId,
    required this.durationSec,
    required this.startHour,
    required this.startMinute,
  });

  final int id;
  final int programId;
  final int zoneId;
  final int durationSec;
  final int startHour;
  final int startMinute;
}
