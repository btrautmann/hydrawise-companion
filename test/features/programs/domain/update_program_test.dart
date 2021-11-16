import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrawise/features/customer_details/customer_details.dart';
import 'package:hydrawise/features/programs/programs.dart';

void main() {
  group('UpdateProgram', () {
    late CustomerDetailsRepository repository;
    late UpdateProgram updateProgram;
    setUp(() {
      repository = InMemoryCustomerDetailsRepository();
      updateProgram = UpdateProgram(repository: repository);
    });
    test('it updates the program name', () async {
      String programId = await repository.createProgram(
        name: 'Original',
        frequency: FrequencyX.none(),
      );

      await updateProgram(
        programId: programId,
        name: 'New',
        frequency: FrequencyX.none(),
        runDrafts: [],
      );

      expect(
        await repository
            .getProgram(programId: programId)
            .then((value) => value.name),
        'New',
      );
    });

    test('it updates the program frequency', () async {
      String programId = await repository.createProgram(
        name: 'Original',
        frequency: FrequencyX.none(),
      );

      await updateProgram(
        programId: programId,
        name: 'New',
        frequency: Frequency(
          monday: true,
          tuesday: false,
          wednesday: false,
          thursday: false,
          friday: false,
          saturday: false,
          sunday: false,
        ),
        runDrafts: [],
      );

      expect(
        await repository
            .getProgram(programId: programId)
            .then((value) => value.frequency.monday),
        isTrue,
      );
    });

    test('it adds a run when a zone is added', () async {
      String programId = await repository.createProgram(
        name: 'Original',
        frequency: FrequencyX.none(),
      );

      final runsBefore =
          await repository.getRunsForProgram(programId: programId);
      expect(runsBefore.length, 0);

      await updateProgram(
        programId: programId,
        name: 'New',
        frequency: Frequency(
          monday: true,
          tuesday: false,
          wednesday: false,
          thursday: false,
          friday: false,
          saturday: false,
          sunday: false,
        ),
        runDrafts: [
          RunDraft.creation(
            timeOfDay: TimeOfDay.now(),
            zoneIds: [1],
            duration: const Duration(seconds: 5),
          ),
        ],
      );

      final runsAfter =
          await repository.getRunsForProgram(programId: programId);

      expect(runsAfter.length, 1);
      expect(runsAfter.single.zoneId, 1);
    });

    test('it removes a run when a zone is removed', () async {
      String programId = await repository.createProgram(
        name: 'Original',
        frequency: FrequencyX.none(),
      );
      await repository.insertRuns(
        programId: programId,
        runs: [
          Run(
            id: 'id-1',
            programId: programId,
            startTime: const TimeOfDay(hour: 9, minute: 9),
            duration: 55,
            zoneId: 1,
          ),
          Run(
            id: 'id-2',
            programId: programId,
            startTime: const TimeOfDay(hour: 9, minute: 9),
            duration: 55,
            zoneId: 2,
          ),
        ],
      );

      final runsBefore =
          await repository.getRunsForProgram(programId: programId);
      expect(runsBefore.length, 2);

      await updateProgram(
        programId: programId,
        name: 'New',
        frequency: FrequencyX.none(),
        runDrafts: [
          RunDraft.modification(
            timeOfDay: TimeOfDay.now(),
            zoneIds: [1],
            duration: const Duration(seconds: 5),
          ),
        ],
      );

      final runsAfter =
          await repository.getRunsForProgram(programId: programId);

      expect(runsAfter.length, 1);
      expect(runsAfter.single.zoneId, 1);
    });

    test('it updates start time and duration of existing zones', () async {
      String programId = await repository.createProgram(
        name: 'Original',
        frequency: FrequencyX.none(),
      );
      await repository.insertRuns(
        programId: programId,
        runs: [
          Run(
            id: 'id-1',
            programId: programId,
            startTime: const TimeOfDay(hour: 9, minute: 9),
            duration: 55,
            zoneId: 1,
          ),
        ],
      );

      final runsBefore =
          await repository.getRunsForProgram(programId: programId);
      expect(runsBefore.single.startTime, const TimeOfDay(hour: 9, minute: 9));
      expect(runsBefore.single.duration, 55);

      await updateProgram(
        programId: programId,
        name: 'New',
        frequency: FrequencyX.none(),
        runDrafts: [
          RunDraft.modification(
            timeOfDay: const TimeOfDay(hour: 5, minute: 5),
            zoneIds: [1],
            duration: const Duration(seconds: 25),
          ),
        ],
      );

      final runsAfter =
          await repository.getRunsForProgram(programId: programId);

      expect(runsAfter.single.startTime, const TimeOfDay(hour: 5, minute: 5));
      expect(runsAfter.single.duration, 25);
    });
  });
}
