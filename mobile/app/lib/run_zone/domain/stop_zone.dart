import 'package:api_models/api_models.dart';
import 'package:core/core.dart';
import 'package:irri/customer_details/customer_details.dart';
import 'package:result_type/result_type.dart';

class StopZone {
  StopZone({
    required HttpClient httpClient,
    required CustomerDetailsRepository repository,
  })  : _httpClient = httpClient,
        _repository = repository;

  final HttpClient _httpClient;
  final CustomerDetailsRepository _repository;

  Future<UseCaseResult<bool, bool>> call({
    required Zone zone,
  }) async {
    final response = await _httpClient.post<Map<String, dynamic>>(
      'stop_zone',
      data: StopZoneRequest(zoneId: zone.id),
    );
    if (response.isSuccess) {
      final runZoneResponse = RunZoneResponse.fromJson(response.success!);
      await _repository.updateZone(
        runZoneResponse.zones.firstWhere((element) => element.id == zone.id),
      );
    }
    return response.isSuccess ? Success(true) : Failure(false);
  }
}
