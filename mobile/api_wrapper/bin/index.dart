import 'package:shelf/shelf.dart';

class Index {
  Response call(Request request) {
    return Response.ok('Hello, World!');
  }
}
