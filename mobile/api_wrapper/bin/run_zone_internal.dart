import 'package:api_models/api_models.dart';
import 'package:http/http.dart' as client;

Future<client.Response> runZone({
  required RunZoneRequest request,
  required String apiKey,
}) async {
  final queryParameters = <String, String>{
    'api_key': apiKey,
    'action': 'run',
    'period_id': '999',
    'custom': request.runLengthSeconds.toString(),
    'relay_id': request.zoneId.toString(),
  };

  return client.get(
    Uri.http(
      'api.hydrawise.com',
      '/api/v1/setzone.php',
      queryParameters,
    ),
  );
}
