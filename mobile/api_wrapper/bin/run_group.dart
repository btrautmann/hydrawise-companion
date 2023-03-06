import 'dart:convert';

import 'package:shelf/shelf.dart';

class RunGroup {
  RunGroup();

  Future<Response> call(Request request) async {
    print('Received request to run group with body ${await request.readAsString()}');
    // TODO(brandon): Grab API key of customer with associated run group id (from program)
    // TODO(brandon): Find all runs for run group and run the correct one.
    // TODO(brandon): Set last_run time for group and runs accordingly
    // TODO(brandon): Create another task for run group with delay of the run group duration
    return Response.ok(
      jsonEncode(<String, dynamic>{'request_handled': true}),
      headers: {'Content-Type': 'application/json'},
    );
  }
}
