import 'package:http/http.dart' as http;
import 'package:shelf/shelf.dart';

/// Dummy end-point for calling ruby's create function
/// to create a task
class TestTasks {
  Future<Response> call(Request request) async {
    final response = await http.post(
      Uri.https('tasks-5rvb357uza-ue.a.run.app', 'create'),
    );
    print(response.body);
    return Response.ok(response.body);
  }
}
