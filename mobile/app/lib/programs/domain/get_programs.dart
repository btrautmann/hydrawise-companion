import 'package:api_models/api_models.dart';
import 'package:core/core.dart';
import 'package:irri/auth/auth.dart';
import 'package:irri/customer_details/repository/customer_details_repository.dart';
import 'package:result_type/result_type.dart';

class GetPrograms {
  GetPrograms({
    required HttpClient httpClient,
    required GetApiKey getApiKey,
    required CustomerDetailsRepository repository,
  })  : _httpClient = httpClient,
        _getApiKey = getApiKey,
        _repository = repository;

  final HttpClient _httpClient;
  final GetApiKey _getApiKey;
  final CustomerDetailsRepository _repository;

  Future<UseCaseResult<GetProgramsResponse, String>> call() async {
    final apiKey = await _getApiKey();

    final queryParameters = {
      'api_key': apiKey!,
    };

    final response = await _httpClient.get<Map<String, dynamic>>(
      'program',
      queryParameters: queryParameters,
    );

    if (response.isSuccess) {
      final getProgramsResponse =
          GetProgramsResponse.fromJson(response.success!);

      for (final program in getProgramsResponse.programs) {
        await _repository.insertProgram(program);
      }

      return Success(getProgramsResponse);
    }

    return Failure(response.failure.message);
  }
}
