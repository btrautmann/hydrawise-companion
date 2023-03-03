import 'dart:convert';

import 'package:shelf/shelf.dart';

class Ping {
  Future<Response> call(Request request) async {
    return Response.ok(jsonEncode({'status': 'normal'}));
  }
}
