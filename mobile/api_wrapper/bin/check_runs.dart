import 'dart:convert';

import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';

class CheckRuns {
  CheckRuns(this.db);

  final PostgreSQLConnection db;

  Future<Response> call(Request request) async {
    return Response.ok(
      jsonEncode(
        {'message': 'ok'},
      ),
    );
  }
}
