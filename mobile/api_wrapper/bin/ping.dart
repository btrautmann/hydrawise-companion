import 'dart:convert';

import 'package:shelf/shelf.dart';

/// Health check end-point
class Ping {
  Future<Response> call(Request request) async {
    return Response.ok(jsonEncode({'status': 'normal'}));
  }
}
