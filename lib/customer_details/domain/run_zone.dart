import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hydrawise/customer_details/api/domain/get_api_key.dart';
import 'package:hydrawise/customer_details/models/run_zone_response.dart';
import 'package:hydrawise/customer_details/models/zone.dart';

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
  Future<RunZoneResponse> call({
    required Zone zone,
    required int runLengthSeconds,
  }) async {
    return RunZoneResponse(
      message: 'Starting zones ${zone.name}. ${zone.name} to run now.',
      typeOfMessage: 'info',
    );
  }
}
