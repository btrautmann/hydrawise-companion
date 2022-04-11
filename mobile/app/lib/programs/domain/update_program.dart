// ignore: implementation_imports
import 'package:collection/src/iterable_extensions.dart';
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
    await _repository.updateProgram(
      programId: programId,
      name: name,
      frequency: frequency,
    );

    final existingRuns = await _repository.getRunsForProgram(
      programId: programId,
    );

    final modifiedrunGroups =
        runGroups.where((element) => !element.isNewRunGroup()).toList();

    final deletedRuns = existingRuns.where(
      (existingRun) => modifiedrunGroups.none(
        (element) =>
            element.zoneIds.contains(existingRun.zoneId) &&
            element.timeOfDay == existingRun.startTime &&
            element.duration.inSeconds == existingRun.duration,
      ),
    );
    for (final run in deletedRuns) {
      await _repository.deleteRun(runId: run.id, programId: programId);
    }

    final runsToInsert = <Run>[];
    final runsToUpdate = <Run>[];
    for (final runGroup in runGroups) {
      for (final zoneId in runGroup.zoneIds) {
        // If the provided runGroup is a modification,
        // we may be adding runs OR updating runs,
        // and as such need to assign the correct Id, either
        // a new one or an existing one
        Future<String> modificationId() async {
          final matchingRun = existingRuns.singleWhereOrNull(
            (existingRun) =>
                existingRun.startTime == runGroup.timeOfDay &&
                existingRun.zoneId == zoneId &&
                existingRun.duration == runGroup.duration.inSeconds,
          );
          // TODO(brandon): Create GetUniqueId to abstract the usage
          // of Uuid
          return matchingRun?.id ?? const Uuid().v4();
        }

        final id = runGroup.isNewRunGroup()
            ? const Uuid().v4()
            : await modificationId();

        final run = Run(
          id: id,
          programId: programId,
          startTime: runGroup.timeOfDay,
          duration: runGroup.duration.inSeconds,
          zoneId: zoneId,
        );
        final isCreating = existingRuns.none((run) => run.id == id);
        if (isCreating) {
          runsToInsert.add(run);
        } else {
          runsToUpdate.add(run);
        }
      }
    }
    await _repository.insertRuns(
      programId: programId,
      runs: runsToInsert,
    );
    await _repository.updateRuns(
      programId: programId,
      runs: runsToUpdate,
    );
  }
}
