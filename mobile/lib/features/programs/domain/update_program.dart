// ignore: implementation_imports
import 'package:collection/src/iterable_extensions.dart';
import 'package:hydrawise/features/customer_details/repository/customer_details_repository.dart';
import 'package:hydrawise/features/programs/programs.dart';
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
    required List<RunDraft> runDrafts,
  }) async {
    await _repository.updateProgram(
      programId: programId,
      name: name,
      frequency: frequency,
    );

    final existingRuns = await _repository.getRunsForProgram(
      programId: programId,
    );

    final modifiedRunDrafts =
        runDrafts.where((element) => !element.isNewRunDraft()).toList();

    final deletedRuns = existingRuns.where(
      (existingRun) => modifiedRunDrafts.none(
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
    for (final runDraft in runDrafts) {
      for (final zoneId in runDraft.zoneIds) {
        // If the provided RunDraft is a modification,
        // we may be adding runs OR updating runs,
        // and as such need to assign the correct Id, either
        // a new one or an existing one
        Future<String> modificationId() async {
          final matchingRun = existingRuns.singleWhereOrNull(
            (existingRun) =>
                existingRun.startTime == runDraft.timeOfDay &&
                existingRun.zoneId == zoneId &&
                existingRun.duration == runDraft.duration.inSeconds,
          );
          // TODO(brandon): Create GetUniqueId to abstract the usage
          // of Uuid
          return matchingRun?.id ?? const Uuid().v4();
        }

        final id = runDraft.map(
          // TODO(brandon): Create GetUniqueId to abstract the usage
          // of Uuid
          creation: (_) async => const Uuid().v4(),
          modification: (r) => modificationId(),
        );

        final runId = await id;

        final run = Run(
          id: runId,
          programId: programId,
          startTime: runDraft.timeOfDay,
          duration: runDraft.duration.inSeconds,
          zoneId: zoneId,
        );
        final isCreating = existingRuns.none((run) => run.id == runId);
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
