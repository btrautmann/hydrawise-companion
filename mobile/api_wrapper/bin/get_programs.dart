import 'package:api_models/api_models.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';

class GetPrograms {
  GetPrograms(this.db);

  final PostgreSQLConnection db;

  Future<Response> call(Request request) async {
    final queryParameters = request.url.queryParameters;

    // TODO(brandon): Auth interception
    final apiKey = queryParameters['api_key'];
    if (apiKey == null) {
      return Response(401);
    }
    final queryResults = await db.query(_findCustomerSql(apiKey));
    if (queryResults.isEmpty) {
      return Response(401);
    }
    final customerId = queryResults.single.toColumnMap()['customer_id'] as int?;
    if (customerId == null) {
      return Response(401);
    }

    final programs = <Program>[];

    await db.transaction((connection) async {
      final programsResult =
          await connection.query(_getProgramsSql(customerId));
      for (final pResult in programsResult) {
        final map = pResult.toColumnMap();
        final programId = map['program_id'] as String;
        final runsResult = await connection.query(_getRunsSql(programId));
        final runs = <Run>[];
        for (final rResult in runsResult) {
          final map = rResult.toColumnMap();
          runs.add(
            Run(
              id: map['run_id'],
              programId: map['program_id'],
              zoneId: map['zone_id'],
              durationSeconds: map['duration_sec'],
              startTime: map['start_time'],
            ),
          );
        }
        programs.add(
          Program(
            id: map['program_id'],
            name: map['name'],
            frequency: map['frequency'],
            runs: runs,
          ),
        );
      }
    });
    return Response.ok(GetProgramsResponse(programs: programs).toJson().toString());
  }
}

String _findCustomerSql(String apiKey) =>
    'SELECT * FROM customer WHERE api_key=\'$apiKey\' LIMIT 1;';

String _getProgramsSql(int customerId) =>
    'SELECT * FROM program WHERE customer_id=$customerId;';

String _getRunsSql(String programId) =>
    'SELECT * FROM run WHERE program_id=\'$programId\';';
