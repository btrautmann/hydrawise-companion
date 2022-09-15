import 'package:postgres/postgres.dart';

import '../../bin/postgres_extensions.dart';
import '../models/db_customer.dart';
import '../models/db_program.dart';
import '../models/db_run.dart';

class GetProgramsByCustomer {
  GetProgramsByCustomer(this.db);

  final PostgreSQLConnection Function() db;

  Future<List<DbProgram>> call(DbCustomer customer) async {
    return db().use((connection) async {
      final programsResult = await connection.query(
        'SELECT * FROM program WHERE customer_id=${customer.id} AND controller_id=${customer.activeControllerId};',
      );

      final programs = <DbProgram>[];
      for (final programRow in programsResult) {
        final programMap = programRow.toColumnMap();
        final programId = programMap['program_id'] as int;
        final runsResult = await connection.query('SELECT * FROM run WHERE program_id=$programId;');
        final runs = <DbRun>[];
        for (final runRow in runsResult) {
          final runMap = runRow.toColumnMap();
          runs.add(
            DbRun(
              id: runMap['run_id'],
              programId: runMap['program_id'],
              zoneId: runMap['zone_id'],
              durationSec: runMap['duration_sec'],
              startHour: runMap['start_hour'],
              startMinute: runMap['start_minute'],
              lastRunTime: runMap['last_run_time'],
            ),
          );
        }
        programs.add(
          DbProgram(
            id: programMap['program_id'],
            customerId: programMap['customer_id'],
            name: programMap['name'],
            frequency: programMap['frequency'],
            runs: runs,
          ),
        );
      }
      return programs;
    });
  }
}
