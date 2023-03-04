class DbRun {
  DbRun({
    required this.id,
    required this.runGroupId,
    required this.zoneId,
    required this.lastRunTime,
  });

  final int id;
  final int runGroupId;
  final int zoneId;
  final DateTime lastRunTime;
}
