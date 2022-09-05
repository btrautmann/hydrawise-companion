// ignore: implementation_imports
import 'package:api_models/api_models.dart';
import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irri/customer_details/repository/customer_details_repository.dart';
import 'package:irri/programs/providers.dart';

part 'update_program_controller.dart';

class UpdateProgram {
  UpdateProgram({
    required HttpClient client,
    required CustomerDetailsRepository repository,
  })  : _client = client,
        _repository = repository;

  final HttpClient _client;
  final CustomerDetailsRepository _repository;

  Future<void> call({
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
      final updateProgramResponse = UpdateProgramResponse.fromJson(response.success!);
      await _repository.updateProgram(updateProgramResponse.program);
    }
  }
}
