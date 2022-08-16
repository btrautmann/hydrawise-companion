import 'package:api_models/api_models.dart';
import 'package:core/core.dart';
import 'package:irri/customer_details/customer_details.dart';
import 'package:result_type/result_type.dart';

// ignore: one_member_abstracts
class RunZone {
  RunZone({
    required HttpClient httpClient,
    required SetNextPollTime setNextPollTime,
    required CustomerDetailsRepository repository,
  })  : _httpClient = httpClient,
        _setNextPollTime = setNextPollTime,
        _repository = repository;

  final HttpClient _httpClient;
  final SetNextPollTime _setNextPollTime;
  final CustomerDetailsRepository _repository;

  Future<UseCaseResult<bool, bool>> call({
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
      await _repository.updateZone(runZoneResponse.zone);
      // Push next poll time back to right after the zone is set
      // to complete, so our state will update correctly
      await _setNextPollTime(secondsUntilNextPoll: runLengthSeconds + 1);
    }
    return response.isSuccess ? Success(true) : Failure(false);
  }
}
