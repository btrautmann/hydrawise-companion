import 'package:api_models/api_models.dart';
import 'package:core/core.dart';

class StopZone {
  StopZone({
    required HttpClient httpClient,
  }) : _httpClient = httpClient;

  final HttpClient _httpClient;

  Future<Zone> call({
    required Zone zone,
  }) async {
    final response = await _httpClient.post<Map<String, dynamic>>(
      'stop_zone',
      data: StopZoneRequest(zoneId: zone.id),
    );
    if (response.isSuccess) {
      final runZoneResponse = RunZoneResponse.fromJson(response.success!);
      return runZoneResponse.zone;
    } else {
      throw Exception(response.failure);
    }
  }
}
