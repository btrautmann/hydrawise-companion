import 'package:api_models/api_models.dart';
import 'package:core/core.dart';

class GetPrograms {
  GetPrograms({
    required HttpClient httpClient,
  }) : _httpClient = httpClient;

  final HttpClient _httpClient;

  Future<List<Program>> call() async {
    final response = await _httpClient.get<Map<String, dynamic>>('program');
    final getProgramsResponse = GetProgramsResponse.fromJson(response.success!);
    return getProgramsResponse.programs;
  }
}
