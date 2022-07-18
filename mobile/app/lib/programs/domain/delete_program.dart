import 'package:api_models/api_models.dart';
import 'package:core/core.dart';
import 'package:irri/customer_details/repository/customer_details_repository.dart';

class DeleteProgram {
  DeleteProgram({
    required HttpClient client,
    required CustomerDetailsRepository repository,
  })  : _httpClient = client,
        _repository = repository;

  final HttpClient _httpClient;
  final CustomerDetailsRepository _repository;

  Future<void> call({required int programId}) async {
    final response = await _httpClient.delete(
      'program',
      data: DeleteProgramRequest(programId: programId),
    );

    if (response.isSuccess) {
      await _repository.deleteProgram(programId: programId);
    }
  }
}
