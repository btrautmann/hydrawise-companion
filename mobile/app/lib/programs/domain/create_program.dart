import 'package:irri/customer_details/customer_details.dart';
import 'package:irri/programs/programs.dart';
import 'package:uuid/uuid.dart';

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
