import 'package:dotenv/dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shelf/shelf.dart';

/// Dummy end-point for calling ruby's create function
/// to create a task
class TestTasks {
  TestTasks(this.env);

  final DotEnv env;
  
  Future<Response> call(Request request) async {
    final response = await http.post(
      Uri.https(env['TASKS_API_END_POINT']!, 'create'),
    );
    print(response.body);
    return Response.ok(response.body);
  }
}
