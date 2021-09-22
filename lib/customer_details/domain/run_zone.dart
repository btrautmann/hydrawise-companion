import 'dart:convert';
import 'package:http/http.dart' as http;
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
    required GetApiKey getApiKey,
  }) : _getApiKey = getApiKey;

  final GetApiKey _getApiKey;

  Future<RunZoneResponse> call({
    required Zone zone,
    required int runLengthSeconds,
  }) async {
    final apiKey = await _getApiKey();
    final queryParameters = {
      'api_key': apiKey,
      'action': 'run',
      'period_id': 999,
      'custom': runLengthSeconds,
      'relay_id': zone.id
    };
    final uri = Uri.https(
      'api.hydrawise.com',
      '/api/v1/setzone.php',
      queryParameters,
    );
    // TODO(brandon): Handle error case
    final response = await http.get(uri);
    return RunZoneResponse.fromJson(
      json.decode(response.body) as Map<String, dynamic>,
    );
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