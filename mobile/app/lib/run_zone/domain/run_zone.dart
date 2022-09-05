import 'package:api_models/api_models.dart';
import 'package:core/core.dart';

// ignore: one_member_abstracts
class RunZone {
  RunZone({
    required HttpClient httpClient,
  }) : _httpClient = httpClient;

  final HttpClient _httpClient;

  Future<Zone> call({
    required Zone zone,
    required int runLengthSeconds,
  }) async {
    final response = await _httpClient.post<Map<String, dynamic>>(
      'run_zone',
      data: RunZoneRequest(
        zoneId: zone.id,
        runLengthSeconds: runLengthSeconds,
      ),
    );

    if (response.isSuccess) {
      final runZoneResponse = RunZoneResponse.fromJson(response.success!);
      return runZoneResponse.zone;
    } else {
      throw Exception(response.failure);
    }
  }
}
