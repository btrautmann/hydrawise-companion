import 'package:api_models/api_models.dart';
import 'package:core/core.dart';
import 'package:result_type/result_type.dart';

class StopZone {
  StopZone({
    required HttpClient httpClient,
  }) : _httpClient = httpClient;

  final HttpClient _httpClient;

  Future<UseCaseResult<bool, bool>> call({
    required Zone zone,
  }) async {
    final response = await _httpClient.post<Map<String, dynamic>>(
      'stop_zone',
      data: StopZoneRequest(zoneId: zone.id),
    );
    return response.isSuccess ? Success(true) : Failure(false);
  }
}
