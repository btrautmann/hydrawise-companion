import 'package:api_models/api_models.dart';
import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irri/customer_details/customer_details.dart';
import 'package:irri/programs/providers.dart';

part 'create_program_controller.dart';

/// Creates a [Program] in the provided [CustomerDetailsRepository]
/// with the given name, frequency, and runs.
class CreateProgram {
  CreateProgram({
    required HttpClient httpClient,
    required CustomerDetailsRepository repository,
  })  : _httpClient = httpClient,
        _repository = repository;

  final HttpClient _httpClient;
  final CustomerDetailsRepository _repository;

  Future<void> call({
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
      await _repository.insertProgram(
        createProgramResponse.program,
      );
    } else {
      throw Exception(response.failure);
    }
  }
}
