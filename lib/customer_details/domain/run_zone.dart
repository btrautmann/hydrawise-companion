import 'package:hydrawise/core/core.dart';
import 'package:hydrawise/customer_details/api/domain/get_api_key.dart';
import 'package:hydrawise/customer_details/models/run_zone_response.dart';
import 'package:hydrawise/customer_details/models/zone.dart';
import 'package:hydrawise/customer_details/repository/customer_details_repository.dart';
import 'package:pedantic/pedantic.dart';

typedef RunZone = Future<RunZoneResponse> Function({
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

  Future<RunZoneResponse> call({
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
    // TODO(brandon): Handle error case
    return RunZoneResponse.fromJson(response.data!);
  }
}

class RunZoneLocally {
  RunZoneLocally({
    required CustomerDetailsRepository repository,
  }) : _repository = repository;

  final CustomerDetailsRepository _repository;

  Future<RunZoneResponse> call({
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

    return RunZoneResponse(
      message: 'Starting zones ${zone.name}. ${zone.name} to run now.',
      typeOfMessage: 'info',
    );
  }
}
