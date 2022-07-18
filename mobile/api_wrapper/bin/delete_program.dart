import 'dart:convert';

import 'package:api_models/api_models.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';

class DeleteProgram {
  DeleteProgram(this.db);

  final PostgreSQLConnection db;

  Future<Response> call(Request request) async {
    final body = await request.readAsString();
    final deleteProgramRequest = DeleteProgramRequest.fromJson(json.decode(body));
    await db.query(_deleteProgramSql(deleteProgramRequest.programId));

    return Response.ok(json.encode(<String, String>{'message': 'program deleted'}));
  }
}

String _deleteProgramSql(int programId) => 'DELETE FROM program WHERE program_id = $programId;';
