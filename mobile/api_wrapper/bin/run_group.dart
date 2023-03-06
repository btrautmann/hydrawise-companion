import 'package:shelf/shelf.dart';

class RunGroup {
  RunGroup();

  Future<Response> call(Request request) async {
    print('Received request to run group');
    return Response.ok(<String, dynamic>{'hello': 'world'});
  }
}
