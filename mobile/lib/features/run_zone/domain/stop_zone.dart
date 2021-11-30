import 'package:dio/dio.dart';
import 'package:irri/core/core.dart';
import 'package:irri/features/auth/auth.dart';
import 'package:irri/features/customer_details/customer_details.dart';
import 'package:irri/features/run_zone/run_zone.dart';
import 'package:result_type/result_type.dart';

typedef StopZone = Future<UseCaseResult<RunZoneResponse, String>> Function({
  required Zone zone,
});

class StopZoneOverNetwork {
  StopZoneOverNetwork({
    required HttpClient httpClient,
    required GetApiKey getApiKey,
  })  : _httpClient = httpClient,
        _getApiKey = getApiKey;

  final GetApiKey _getApiKey;
  final HttpClient _httpClient;

  Future<UseCaseResult<RunZoneResponse, String>> call({
    required Zone zone,
  }) async {
    final apiKey = await _getApiKey();
    final queryParameters = {
      'api_key': apiKey!,
      'action': 'stop',
      'relay_id': zone.id
    };
    final response = await _httpClient.get<Map<String, dynamic>>(
      'setzone.php',
      queryParameters: queryParameters,
    );
    return response
        .map<RunZoneResponse, DioError>(
          (result) => RunZoneResponse.fromJson(result!),
        )
        .mapError<RunZoneResponse, String>(
          (error) => "Can't stop ${zone.name}",
        );
  }
}

class StopZoneLocally {
  StopZoneLocally({
    required CustomerDetailsRepository repository,
  }) : _repository = repository;

  final CustomerDetailsRepository _repository;

  Future<UseCaseResult<RunZoneResponse, String>> call({
    required Zone zone,
  }) async {
    final stoppedZone = zone.copyWith(
      lengthOfNextRunTimeOrTimeRemaining: 60,
      secondsUntilNextRun: 100,
    );

    await Future<void>.delayed(const Duration(seconds: 3));

    await _repository.updateZone(stoppedZone);

    return Success(
      RunZoneResponse(
        message: 'Stopping zones ${zone.name}. ${zone.name} to stop now.',
        typeOfMessage: 'info',
      ),
    );
  }
}
