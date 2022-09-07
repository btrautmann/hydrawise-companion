import 'package:api_models/api_models.dart';
import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irri/programs/providers.dart';
import 'package:irri/programs/update_program/update_program.dart';

part 'create_program_controller.dart';

/// Creates a [Program] with the given name, frequency, and runs.
class CreateProgram {
  CreateProgram({
    required HttpClient httpClient,
  }) : _httpClient = httpClient;

  final HttpClient _httpClient;

  Future<Program> call({
    required String name,
    required List<int> frequency,
    required List<RunCreation> runGroups,
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
      final createProgramResponse = CreateProgramResponse.fromJson(
        response.success!,
      );
      return createProgramResponse.program;
    } else {
      throw Exception(response.failure);
    }
  }
}
