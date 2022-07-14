import 'package:api_models/api_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irri/customer_details/customer_details.dart';
import 'package:irri/programs/programs.dart';

void main() {
  group('UpdateProgram', () {
    late CustomerDetailsRepository repository;
    late UpdateProgram updateProgram;
    setUp(() {
      repository = InMemoryCustomerDetailsRepository();
      updateProgram = UpdateProgram(repository: repository);
    });
    test('it updates the program name', () async {
      await repository.insertProgram(
        Program(
          id: '12345',
          name: 'Original',
          frequency: [],
          runs: List.empty(),
        ),
      );

      await updateProgram(
        programId: '12345',
        name: 'New',
        frequency: [],
        runGroups: [],
      );

      expect(
        await repository
            .getProgram(programId: '12345')
            .then((value) => value.name),
        'New',
      );
    });

    test('it updates the program frequency', () async {
      await repository.insertProgram(
        Program(
          id: '12345',
          name: 'Original',
          frequency: [],
          runs: List.empty(),
        ),
      );

      await updateProgram(
        programId: '12345',
        name: 'New',
        frequency: [DateTime.monday],
        runGroups: [],
      );

      expect(
        await repository
            .getProgram(programId: '12345')
            .then((value) => value.frequency.contains(DateTime.monday)),
        isTrue,
      );
    });

    test('it adds a run when a zone is added', () async {
      await repository.insertProgram(
        Program(
          id: '12345',
          name: 'Original',
          frequency: [],
          runs: List.empty(),
        ),
      );

      final runsBefore =
          await repository.getRunsForProgram(programId: '12345');
      expect(runsBefore.length, 0);

      await updateProgram(
        programId: '12345',
        name: 'New',
        frequency: [DateTime.monday],
        runGroups: [
          RunGroup(
            type: RunGroupType.creation,
            timeOfDay: TimeOfDay.now(),
            zoneIds: [1],
            duration: const Duration(seconds: 5),
          ),
        ],
      );

      final runsAfter =
          await repository.getRunsForProgram(programId: '12345');

      expect(runsAfter.length, 1);
      expect(runsAfter.single.zoneId, 1);
    });

    test('it removes a run when a zone is removed', () async {
      await repository.insertProgram(
        Program(
          id: '12345',
          name: 'Original',
          frequency: [],
          runs: List.empty(),
        ),
      );
      await repository.insertRuns(
        programId: '12345',
        runs: [
          Run(
            id: 'id-1',
            programId: '12345',
            startHour: 9,
            startMinute: 9,
            durationSeconds: 55,
            zoneId: 1,
          ),
          Run(
            id: 'id-2',
            programId: '12345',
            startHour: 9,
            startMinute: 9,
            durationSeconds: 55,
            zoneId: 2,
          ),
        ],
      );

      final runsBefore =
          await repository.getRunsForProgram(programId: '12345');
      expect(runsBefore.length, 2);

      await updateProgram(
        programId: '12345',
        name: 'New',
        frequency: [],
        runGroups: [
          RunGroup(
            type: RunGroupType.modification,
            timeOfDay: TimeOfDay.now(),
            zoneIds: [1],
            duration: const Duration(seconds: 5),
          ),
        ],
      );

      final runsAfter =
          await repository.getRunsForProgram(programId: '12345');

      expect(runsAfter.length, 1);
      expect(runsAfter.single.zoneId, 1);
    });

    test('it updates start time and duration of existing zones', () async {
      await repository.insertProgram(
        Program(
          id: '12345',
          name: 'Original',
          frequency: [],
          runs: List.empty(),
        ),
      );
      await repository.insertRuns(
        programId: '12345',
        runs: [
          Run(
            id: 'id-1',
            programId: '12345',
            startHour: 9,
            startMinute: 9,
            durationSeconds: 55,
            zoneId: 1,
          ),
        ],
      );

      final runsBefore =
          await repository.getRunsForProgram(programId: '12345');
      expect(runsBefore.single.startTime, const TimeOfDay(hour: 9, minute: 9));
      expect(runsBefore.single.durationSeconds, 55);

      await updateProgram(
        programId: '12345',
        name: 'New',
        frequency: [],
        runGroups: [
          RunGroup(
            type: RunGroupType.modification,
            timeOfDay: const TimeOfDay(hour: 5, minute: 5),
            zoneIds: [1],
            duration: const Duration(seconds: 25),
          ),
        ],
      );

      final runsAfter =
          await repository.getRunsForProgram(programId: '12345');

      expect(runsAfter.single.startTime, const TimeOfDay(hour: 5, minute: 5));
      expect(runsAfter.single.durationSeconds, 25);
    });
  });
}
