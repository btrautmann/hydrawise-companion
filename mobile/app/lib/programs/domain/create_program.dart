import 'package:api_models/api_models.dart';
import 'package:core/core.dart';
import 'package:irri/auth/auth.dart';
import 'package:irri/customer_details/customer_details.dart';
import 'package:irri/programs/programs.dart';
import 'package:result_type/result_type.dart';

/// Creates a [Program] in the provided [CustomerDetailsRepository]
/// with the given name, frequency, and runs.
///
/// The [RunGroup]s passed to [call] are broken up into the individual
/// [Run]s that comprise the [RunGroup] and stored individually, associated
/// with the created [Program] via the [Program]s id.
///
/// Each created [Run] has the same duration and start time as the parent
/// [RunGroup].
class CreateProgram {
  CreateProgram({
    required HttpClient httpClient,
    required GetApiKey getApiKey,
    required CustomerDetailsRepository repository,
  })  : _httpClient = httpClient,
        _getApiKey = getApiKey,
        _repository = repository;

  final HttpClient _httpClient;
  final GetApiKey _getApiKey;
  final CustomerDetailsRepository _repository;

  Future<UseCaseResult<String, String>> call({
    required String name,
    required List<int> frequency,
    required List<RunGroup> runGroups,
  }) async {
    final apiKey = await _getApiKey();

    final runs = <RunCreation>[];
    for (final group in runGroups) {
      for (final zoneId in group.zoneIds) {
        runs.add(
          RunCreation(
            startHour: group.timeOfDay.hour,
            startMinute: group.timeOfDay.minute,
            durationSeconds: group.duration.inSeconds,
            zoneId: zoneId,
          ),
        );
      }
    }

    final response = await _httpClient.post<Map<String, dynamic>>(
      'program',
      data: CreateProgramRequest(
        apiKey: apiKey!,
        programName: name,
        frequency: frequency,
        runs: runs,
      ),
    );

    if (response.isSuccess) {
      final createProgramResponse =
          CreateProgramResponse.fromJson(response.success!);
      await _repository.insertProgram(createProgramResponse.program);
      return Success('Created program');
    }

    return Failure(response.failure.message);
  }
}
