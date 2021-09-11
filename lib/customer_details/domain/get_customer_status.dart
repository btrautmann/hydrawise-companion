import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hydrawise/customer_details/models/customer_status.dart';

typedef GetCustomerStatus = Future<CustomerStatus> Function({
  required String apiKey,
  int? activeControllerId,
});

class GetRealCustomerStatus {
  Future<CustomerStatus> call({
    required String apiKey,
    int? activeControllerId,
  }) async {
    final queryParameters = {
      'api_key': apiKey,
    };
    if (activeControllerId != null) {
      queryParameters['controller_id'] = activeControllerId.toString();
    }
    final uri = Uri.https(
      'api.hydrawise.com',
      '/api/v1/statusschedule.php',
      queryParameters,
    );
    final response = await http.get(uri);
    return CustomerStatus.fromJson(
      json.decode(response.body) as Map<String, dynamic>,
    );
  }
}

class GetFakeCustomerStatus {
  Future<CustomerStatus> call({
    required String apiKey,
    int? activeControllerId,
  }) async {
    return CustomerStatus(
      statusMessage: 'All good!',
      numberOfSecondsUntilNextRequest: 100,
      timeOfLastStatusUnixEpoch: 1631330889,
      zones: [],
    );
  }
}
