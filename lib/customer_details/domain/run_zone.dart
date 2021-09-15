import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hydrawise/customer_details/models/run_zone_response.dart';
import 'package:hydrawise/customer_details/models/zone.dart';

typedef RunZone = Future<RunZoneResponse> Function(
    String apiKey, Zone zone, int runLengthSeconds);

class RunZoneOverNetwork {
  Future<RunZoneResponse> call(
    String apiKey,
    Zone zone,
    int runLengthSeconds,
  ) async {
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
  Future<RunZoneResponse> call(
    String apiKey,
    Zone zone,
    int runLengthSeconds,
  ) async {
    return RunZoneResponse(
      message: 'Starting zones ${zone.name}. ${zone.name} to run now.',
      typeOfMessage: 'info',
    );
  }
}
