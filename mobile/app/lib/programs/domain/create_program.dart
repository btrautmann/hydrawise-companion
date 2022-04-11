import 'package:irri/customer_details/customer_details.dart';
import 'package:irri/programs/programs.dart';
import 'package:uuid/uuid.dart';

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
    required CustomerDetailsRepository repository,
  }) : _repository = repository;

  final CustomerDetailsRepository _repository;

  Future<void> call({
    required String name,
    required List<int> frequency,
    required List<RunGroup> runGroups,
  }) async {
    final programId = await _repository.createProgram(
      name: name,
      frequency: frequency,
    );
    final runs = <Run>[];
    for (final group in runGroups) {
      for (final zoneId in group.zoneIds) {
        runs.add(
          Run(
            id: const Uuid().v4(),
            programId: programId,
            startTime: group.timeOfDay,
            duration: group.duration.inSeconds,
            zoneId: zoneId,
          ),
        );
      }
    }
    await _repository.insertRuns(
      programId: programId,
      runs: runs,
    );
  }
}