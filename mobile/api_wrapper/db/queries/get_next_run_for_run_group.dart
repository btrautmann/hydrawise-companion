import 'package:postgres/postgres.dart';

import '../models/db_program.dart';
import '../models/db_run_group.dart';

class GetNextRunForRunGroup {
  GetNextRunForRunGroup(this.db);

  final PostgreSQLConnection Function() db;

  DateTime call({
    required DbRunGroup group,
    required DbProgram program,
  }) {
    // TODO(brandon): When suspension ability is added, start at the suspension
    // time rather than lastRunTime.
    final groupLastRunTime = group.lastRunTime ?? //
        // Default to epoch if group has never run
        DateTime.fromMillisecondsSinceEpoch(0);
    final programFrequency = program.frequency;
    const oneDay = Duration(days: 1);
    final now = DateTime.now();
    final nextWeek = List.generate(7, (i) {
      return now.add(Duration(days: i + 1));
    });
    final nextRun = nextWeek.firstWhere((day) {
      // Run groups run at most once a day, so next run must be
      // 24 hours after the previous
      return day.isAfter(groupLastRunTime.add(oneDay)) && //
          programFrequency.contains(day.weekday);
    });
    return nextRun;
  }
}
