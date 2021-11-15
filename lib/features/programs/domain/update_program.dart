// ignore: implementation_imports
import 'package:collection/src/iterable_extensions.dart';
import 'package:hydrawise/features/customer_details/repository/customer_details_repository.dart';
import 'package:hydrawise/features/programs/programs.dart';
import 'package:uuid/uuid.dart';

class UpdateProgram {
  final CustomerDetailsRepository _repository;

  UpdateProgram({
    required CustomerDetailsRepository repository,
  }) : _repository = repository;

  Future<void> call({
    required String programId,
    required String name,
    required Frequency frequency,
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

    final modifiedRunDrafts = runDrafts.where((element) => !element.isNewRunDraft()).toList();

    final deletedRuns = existingRuns.where(
      (existingRun) => modifiedRunDrafts.none(
        (element) =>
            element.zoneIds.contains(existingRun.zoneId) &&
            element.timeOfDay == existingRun.startTime &&
            element.duration.inSeconds == existingRun.duration,
      ),
    );
    for (final run in deletedRuns) {
      await _repository.deleteRun(runId: run.id);
    }

    final runsToInsert = <Run>[];
    final runsToUpdate = <Run>[];
    for (final runDraft in runDrafts) {
      for (final zoneId in runDraft.zoneIds) {
        // If the provided RunDraft is a modification,
        // we may be adding runs OR updating runs,
        // and as such need to assign the correct existing
        // or new ID to the run being saved
        Future<String> modificationId() async {
          // Get run matching programId and zoneId and start time

          final matchingRun = existingRuns.singleWhereOrNull(
            (existingRun) =>
                existingRun.startTime == runDraft.timeOfDay &&
                existingRun.zoneId == zoneId &&
                existingRun.duration == runDraft.duration.inSeconds,
          );
          // if it exists, return its ID, otherwise a new Id
          return matchingRun?.id ?? const Uuid().v4().toString();
        }

        // Assign the correct ID based on whether this RunDraft
        // is being created or modified
        final Future<String> id = runDraft.map(
          // We're creating a run, create a new Id
          creation: (_) async => const Uuid().v4().toString(),
          // We're modified an existing run, use its Id
          modification: (r) => modificationId(),
        );

        final String runId = await id;

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
