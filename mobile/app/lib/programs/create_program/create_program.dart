import 'package:api_models/api_models.dart';
import 'package:core/core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:irri/programs/providers.dart';

part 'create_program_controller.dart';

class CreateProgram {
  CreateProgram({
    required HttpClient httpClient,
  }) : _httpClient = httpClient;

  final HttpClient _httpClient;

  Future<Program> call({
    required String name,
    required List<int> frequency,
    required List<RunGroupCreation> runGroups,
  }) async {
    final response = await _httpClient.post<Map<String, dynamic>>(
      'program',
      data: CreateProgramRequest(
        programName: name,
        frequency: frequency,
        runs: runGroups,
      ),
    );

    if (response.isSuccess) {
      final createProgramResponse = CreateProgramResponse.fromJson(response.success!);
      return createProgramResponse.program;
    } else {
      throw Exception(response.failure);
    }
  }
}
