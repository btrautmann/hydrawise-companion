import 'package:shelf/shelf.dart';

class Index {
  Response call(Request request) => Response.ok('Hello, World!');
}
