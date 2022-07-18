// ignore: implementation_imports
import 'package:api_models/api_models.dart';
import 'package:collection/collection.dart';
import 'package:core/core.dart';
import 'package:irri/customer_details/repository/customer_details_repository.dart';
import 'package:irri/programs/programs.dart';

class UpdateProgram {
  UpdateProgram({
    required HttpClient client,
    required CustomerDetailsRepository repository,
  })  : _client = client,
        _repository = repository;

  final HttpClient _client;
  final CustomerDetailsRepository _repository;

  Future<void> call({
    required int programId,
    required String name,
    required List<int> frequency,
    required List<RunGroup> runGroups,
  }) async {
    final existingProgram = await _repository.getProgram(programId: programId);

    final modifiedGroups = runGroups.where((group) => !group.isNewRunGroup()).toList();

    // Delete any runs that are no longer found in any of the "modification" groups
    final runsToDelete = existingProgram.runs
        .where(
          (existingRun) => modifiedGroups.none(
            (group) =>
                group.zoneIds.contains(existingRun.zoneId) &&
                group.timeOfDay == existingRun.startTime &&
                group.duration.inSeconds == existingRun.durationSeconds,
          ),
        )
        .toList();

    final runsToInsert = <RunCreation>[];
    final runsToUpdate = <Run>[];
    for (final runGroup in runGroups) {
      for (final zoneId in runGroup.zoneIds) {
        // If the provided runGroup is a modification,
        // we may be adding runs OR updating runs,
        // and as such need to assign the correct Id, either
        // a new one or an existing one
        Run? existingRun() {
          return existingProgram.runs.singleWhereOrNull(
            (existingRun) =>
                existingRun.startTime == runGroup.timeOfDay &&
                existingRun.zoneId == zoneId &&
                existingRun.durationSeconds == runGroup.duration.inSeconds,
          );
        }

        if (runGroup.isNewRunGroup() || existingRun() == null) {
          runsToInsert.add(
            RunCreation(
              zoneId: zoneId,
              durationSeconds: runGroup.duration.inSeconds,
              startHour: runGroup.timeOfDay.hour,
              startMinute: runGroup.timeOfDay.minute,
            ),
          );
        } else {
          runsToUpdate.add(existingRun()!);
        }
      }
    }
    final response = await _client.put<Map<String, dynamic>>(
      'program',
      data: UpdateProgramRequest(
        programId: programId,
        programName: name,
        frequency: frequency,
        runsToCreate: runsToInsert,
        runsToUpdate: runsToUpdate,
        runsToDelete: runsToDelete,
      ),
    );
    if (response.isSuccess) {
      final updateProgramResponse = UpdateProgramResponse.fromJson(response.success!);
      await _repository.updateProgram(updateProgramResponse.program);
    }
  }
}
