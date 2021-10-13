import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hydrawise/core/core.dart';
import 'package:hydrawise/customer_details/api/domain/get_api_key.dart';
import 'package:hydrawise/customer_details/models/run_zone_response.dart';
import 'package:hydrawise/customer_details/models/zone.dart';
import 'package:hydrawise/customer_details/repository/customer_details_repository.dart';

typedef StopZone = Future<RunZoneResponse> Function({
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

  Future<RunZoneResponse> call({
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
    // TODO(brandon): Handle error case
    return RunZoneResponse.fromJson(response.data!);
  }
}

class StopZoneLocally {
  StopZoneLocally({
    required CustomerDetailsRepository repository,
  }) : _repository = repository;

  final CustomerDetailsRepository _repository;

  Future<RunZoneResponse> call({
    required Zone zone,
  }) async {
    final stoppedZone = zone.copyWith(
      lengthOfNextRunTimeOrTimeRemaining: 60,
      secondsUntilNextRun: 100,
    );

    await Future<void>.delayed(const Duration(seconds: 3));

    await _repository.updateZone(stoppedZone);

    return RunZoneResponse(
      message: 'Stopping zones ${zone.name}. ${zone.name} to stop now.',
      typeOfMessage: 'info',
    );
  }
}
