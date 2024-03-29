import 'dart:convert';

import 'package:api_models/api_models.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';

import 'utils/_postgresql_connection.dart';

class DeleteProgram {
  DeleteProgram(this.db);

  final PostgreSQLConnection Function() db;

  Future<Response> call(Request request) async {
    return db().use((connection) async {
      final body = await request.readAsString();
      final deleteProgramRequest = DeleteProgramRequest.fromJson(
        json.decode(
          body,
        ),
      );
      await connection.query(
        _deleteProgramSql(
          deleteProgramRequest.programId,
        ),
      );

      return Response.ok(
        jsonEncode(
          <String, String>{
            'message': 'program deleted',
          },
        ),
        headers: {'Content-Type': 'application/json'},
      );
    });
  }
}

String _deleteProgramSql(int programId) => 'DELETE FROM program WHERE program_id = $programId;';
