import 'package:dio/dio.dart';
import 'package:hydrawise/core/core.dart';
import 'package:hydrawise/customer_details/api/domain/get_api_key.dart';
import 'package:hydrawise/customer_details/models/run_zone_response.dart';
import 'package:hydrawise/customer_details/models/zone.dart';
import 'package:hydrawise/customer_details/repository/customer_details_repository.dart';
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
            (result) => RunZoneResponse.fromJson(result!))
        .mapError<RunZoneResponse, String>((error) => "Can't stop ${zone.name}");
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

    return Success(RunZoneResponse(
      message: 'Stopping zones ${zone.name}. ${zone.name} to stop now.',
      typeOfMessage: 'info',
    ));
  }
}
