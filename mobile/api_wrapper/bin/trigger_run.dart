import 'dart:convert';

import 'package:dotenv/dotenv.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';

class TriggerRun {
  TriggerRun(this.db, this.env);

  final PostgreSQLConnection Function() db;
  final DotEnv env;

  Future<Response> call(Request request) async {
    return Response.ok(
      jsonEncode(<String, dynamic>{'request_handled': true}),
      headers: {'Content-Type': 'application/json'},
    );
  }
}
