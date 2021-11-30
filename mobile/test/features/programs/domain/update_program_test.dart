import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irri/features/customer_details/customer_details.dart';
import 'package:irri/features/programs/programs.dart';

void main() {
  group('UpdateProgram', () {
    late CustomerDetailsRepository repository;
    late UpdateProgram updateProgram;
    setUp(() {
      repository = InMemoryCustomerDetailsRepository();
      updateProgram = UpdateProgram(repository: repository);
    });
    test('it updates the program name', () async {
      final programId = await repository.createProgram(
        name: 'Original',
        frequency: [],
      );

      await updateProgram(
        programId: programId,
        name: 'New',
        frequency: [],
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
      final programId = await repository.createProgram(
        name: 'Original',
        frequency: [],
      );

      await updateProgram(
        programId: programId,
        name: 'New',
        frequency: [DateTime.monday],
        runDrafts: [],
      );

      expect(
        await repository
            .getProgram(programId: programId)
            .then((value) => value.frequency.contains(DateTime.monday)),
        isTrue,
      );
    });

    test('it adds a run when a zone is added', () async {
      final programId = await repository.createProgram(
        name: 'Original',
        frequency: [],
      );

      final runsBefore =
          await repository.getRunsForProgram(programId: programId);
      expect(runsBefore.length, 0);

      await updateProgram(
        programId: programId,
        name: 'New',
        frequency: [DateTime.monday],
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
      final programId = await repository.createProgram(
        name: 'Original',
        frequency: [],
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
        frequency: [],
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
      final programId = await repository.createProgram(
        name: 'Original',
        frequency: [],
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
        frequency: [],
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
