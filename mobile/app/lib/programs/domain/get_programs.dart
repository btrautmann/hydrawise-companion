import 'package:api_models/api_models.dart';
import 'package:core/core.dart';
import 'package:irri/customer_details/repository/customer_details_repository.dart';
import 'package:result_type/result_type.dart';

class GetPrograms {
  GetPrograms({
    required HttpClient httpClient,
    required CustomerDetailsRepository repository,
  })  : _httpClient = httpClient,
        _repository = repository;

  final HttpClient _httpClient;
  final CustomerDetailsRepository _repository;

  Future<UseCaseResult<GetProgramsResponse, String>> call() async {
    final response = await _httpClient.get<Map<String, dynamic>>('program');

    if (response.isSuccess) {
      final getProgramsResponse = GetProgramsResponse.fromJson(response.success!);

      for (final program in getProgramsResponse.programs) {
        await _repository.insertProgram(program);
      }

      return Success(getProgramsResponse);
    }

    return Failure(response.failure.message);
  }
}
