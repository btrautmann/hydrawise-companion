import 'package:dio/dio.dart';
import 'package:hydrawise/core/core.dart';
import 'package:hydrawise/customer_details/api/domain/get_api_key.dart';
import 'package:hydrawise/customer_details/models/run_zone_response.dart';
import 'package:hydrawise/customer_details/models/zone.dart';
import 'package:hydrawise/customer_details/repository/customer_details_repository.dart';
import 'package:pedantic/pedantic.dart';
import 'package:result_type/result_type.dart';

typedef RunZone = Future<UseCaseResult<RunZoneResponse, String>> Function({
  required Zone zone,
  required int runLengthSeconds,
});

class RunZoneOverNetwork {
  RunZoneOverNetwork({
    required HttpClient httpClient,
    required GetApiKey getApiKey,
  })  : _httpClient = httpClient,
        _getApiKey = getApiKey;

  final GetApiKey _getApiKey;
  final HttpClient _httpClient;

  Future<UseCaseResult<RunZoneResponse, String>> call({
    required Zone zone,
    required int runLengthSeconds,
  }) async {
    final apiKey = await _getApiKey();
    final queryParameters = {
      'api_key': apiKey!,
      'action': 'run',
      'period_id': 999,
      'custom': runLengthSeconds,
      'relay_id': zone.id
    };
    final response = await _httpClient.get<Map<String, dynamic>>(
      'setzone.php',
      queryParameters: queryParameters,
    );
    return response
        .map<RunZoneResponse, DioError>(
            (result) => RunZoneResponse.fromJson(result!))
        .mapError<RunZoneResponse, String>(
          (error) => "Can't run ${zone.name}. ${error.message}",
        );
  }
}

class RunZoneLocally {
  RunZoneLocally({
    required CustomerDetailsRepository repository,
  }) : _repository = repository;

  final CustomerDetailsRepository _repository;

  Future<Result<RunZoneResponse, String>> call({
    required Zone zone,
    required int runLengthSeconds,
  }) async {
    final runningZone = zone.copyWith(
      lengthOfNextRunTimeOrTimeRemaining: runLengthSeconds,
      secondsUntilNextRun: 1,
    );

    await Future<void>.delayed(const Duration(seconds: 3));

    await _repository.updateZone(runningZone);

    // Turn the zone back off
    unawaited(
      Future.delayed(Duration(seconds: runLengthSeconds), () {
        _repository.updateZone(
          zone.copyWith(
            secondsUntilNextRun: 60,
            lengthOfNextRunTimeOrTimeRemaining: 60,
          ),
        );
      }),
    );

    return Success(RunZoneResponse(
      message: 'Starting zones ${zone.name}. ${zone.name} to run now.',
      typeOfMessage: 'info',
    ));
  }
}
