import 'package:dio/dio.dart';
import 'package:hydrawise/core/core.dart';
import 'package:hydrawise/features/auth/auth.dart';
import 'package:hydrawise/features/customer_details/customer_details.dart';
import 'package:hydrawise/features/run_zone/run_zone.dart';
import 'package:pedantic/pedantic.dart';
import 'package:result_type/result_type.dart';

abstract class RunZone {
  Future<UseCaseResult<RunZoneResponse, String>> call({
    required Zone zone,
    required int runLengthSeconds,
  });
}

class RunZoneOverNetwork implements RunZone {
  RunZoneOverNetwork({
    required HttpClient httpClient,
    required GetApiKey getApiKey,
    required SetNextPollTime setNextPollTime,
    required CustomerDetailsRepository repository,
  })  : _httpClient = httpClient,
        _getApiKey = getApiKey,
        _setNextPollTime = setNextPollTime,
        _repository = repository;

  final GetApiKey _getApiKey;
  final HttpClient _httpClient;
  final SetNextPollTime _setNextPollTime;
  final CustomerDetailsRepository _repository;

  @override
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
    final response = await _httpClient
        .get<Map<String, dynamic>>(
      'setzone.php',
      queryParameters: queryParameters,
    )
        .then((result) {
      if (result.isSuccess) {
        _repository.updateZone(
          zone.copyWith(
            secondsUntilNextRun: 1,
            lengthOfNextRunTimeOrTimeRemaining: runLengthSeconds,
          ),
        );
        // Push next poll time back to right after the zone is set
        // to complete, so our state will update correctly
        _setNextPollTime(secondsUntilNextPoll: runLengthSeconds + 1);
      }
    });

    return response
        .map<RunZoneResponse, DioError>((result) => RunZoneResponse.fromJson(result!))
        .mapError<RunZoneResponse, String>(
          (error) => "Can't run ${zone.name}. ${error.message}",
        );
  }
}

class RunZoneLocally implements RunZone {
  RunZoneLocally({
    required CustomerDetailsRepository repository,
  }) : _repository = repository;

  final CustomerDetailsRepository _repository;

  @override
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
