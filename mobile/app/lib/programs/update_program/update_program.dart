// ignore: implementation_imports
import 'package:api_models/api_models.dart';
import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irri/programs/providers.dart';

part 'update_program_controller.dart';

class UpdateProgram {
  UpdateProgram({
    required HttpClient client,
  }) : _client = client;

  final HttpClient _client;

  Future<Program> call({
    required int programId,
    required String name,
    required List<int> frequency,
    required List<RunCreation> runGroups,
  }) async {
    final response = await _client.put<Map<String, dynamic>>(
      'program',
      data: UpdateProgramRequest(
        programId: programId,
        programName: name,
        frequency: frequency,
        runs: runGroups,
      ),
    );
    if (response.isSuccess) {
      final updateProgramResponse =
          UpdateProgramResponse.fromJson(response.success!);
      return updateProgramResponse.program;
    } else {
      throw Exception(response.failure);
    }
  }
}
