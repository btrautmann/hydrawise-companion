// ignore: implementation_imports
import 'package:api_models/api_models.dart';
import 'package:collection/collection.dart';
import 'package:irri/customer_details/repository/customer_details_repository.dart';
import 'package:irri/programs/programs.dart';
import 'package:uuid/uuid.dart';

class UpdateProgram {
  UpdateProgram({
    required CustomerDetailsRepository repository,
  }) : _repository = repository;

  final CustomerDetailsRepository _repository;

  Future<void> call({
    required String programId,
    required String name,
    required List<int> frequency,
    required List<RunGroup> runGroups,
  }) async {
    final existingProgram = await _repository.getProgram(programId: programId);

    final runsToInsert = <Run>[];
    final runsToUpdate = <Run>[];
    for (final runGroup in runGroups) {
      for (final zoneId in runGroup.zoneIds) {
        // If the provided runGroup is a modification,
        // we may be adding runs OR updating runs,
        // and as such need to assign the correct Id, either
        // a new one or an existing one
        String modificationId() {
          final matchingRun = existingProgram.runs.singleWhereOrNull(
            (existingRun) =>
                existingRun.startTime == runGroup.timeOfDay &&
                existingRun.zoneId == zoneId &&
                existingRun.durationSeconds == runGroup.duration.inSeconds,
          );
          // TODO(brandon): Create GetUniqueId to abstract the usage
          // of Uuid
          return matchingRun?.id ?? const Uuid().v4();
        }

        final id = runGroup.isNewRunGroup() ? const Uuid().v4() : modificationId();

        final run = Run(
          id: id,
          programId: programId,
          startHour: runGroup.timeOfDay.hour,
          startMinute: runGroup.timeOfDay.minute,
          durationSeconds: runGroup.duration.inSeconds,
          zoneId: zoneId,
        );
        final isCreating = existingProgram.runs.none((run) => run.id == id);
        if (isCreating) {
          runsToInsert.add(run);
        } else {
          runsToUpdate.add(run);
        }
      }
    }

    await _repository.updateProgram(
      existingProgram.copyWith(
        name: name,
        frequency: frequency,
        runs: <Run>[...runsToInsert, ...runsToUpdate],
      ),
    );
  }
}
