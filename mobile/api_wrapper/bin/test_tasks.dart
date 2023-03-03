import 'package:http/http.dart' as http;
import 'package:shelf/shelf.dart';

class TestTasks {
  Future<Response> call(Request request) async {
    final response = await http.post(
      Uri.https('tasks-5rvb357uza-ue.a.run.app/create'),
    );
    print(response.body);
    return Response.ok(response.body);
  }
}
