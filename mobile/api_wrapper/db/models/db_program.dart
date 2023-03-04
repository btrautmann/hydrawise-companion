import 'db_run_group.dart';

class DbProgram {
  DbProgram({
    required this.id,
    required this.customerId,
    required this.name,
    required this.frequency,
    required this.runs,
  });

  final int id;
  final int customerId;
  final String name;
  final List<int> frequency;
  final List<DbRunGroup> runs;
}
