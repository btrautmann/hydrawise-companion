import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irri/customer_details/repository/repository.dart';
import 'package:irri/programs/programs.dart';

void main() {
  group('CreateProgram', () {
    final repository = InMemoryCustomerDetailsRepository();

    setUp(repository.clearAllData);

    test('it creates a program with the name and frequency', () async {
      final subject = CreateProgram(repository: repository);

      await subject.call(
        name: 'Test Program',
        frequency: [1, 2, 3, 4, 5],
        runGroups: <RunGroup>[],
      );

      final programs = await repository.getPrograms();

      expect(programs.length, 1);
      expect(programs.single.name, 'Test Program');
      expect(programs.single.frequency, [1, 2, 3, 4, 5]);
    });

    test('it creates runs with the correct attributes', () async {
      final subject = CreateProgram(repository: repository);

      final time = DateTime.now();
      await subject.call(
        name: 'Test Program',
        frequency: [1, 2, 3, 4, 5],
        runGroups: <RunGroup>[
          RunGroup(
            type: RunGroupType.creation,
            timeOfDay: TimeOfDay.fromDateTime(time),
            zoneIds: [0, 1],
            duration: const Duration(minutes: 10),
          ),
          RunGroup(
            type: RunGroupType.creation,
            timeOfDay:
                TimeOfDay.fromDateTime(time.add(const Duration(hours: 2))),
            zoneIds: [2, 3],
            duration: const Duration(minutes: 15),
          ),
        ],
      );

      final programs = await repository.getPrograms();
      final runs = programs.single.runs!;

      expect(runs.toRunGroups().length, 2);

      final firstRuns = runs.where(
        (r) => r.duration == 600 && r.startTime == TimeOfDay.fromDateTime(time),
      );
      expect(
        firstRuns.length,
        2,
      );
      final secondRuns = runs.where(
        (r) =>
            r.duration == 900 &&
            r.startTime ==
                TimeOfDay.fromDateTime(
                  time.add(
                    const Duration(hours: 2),
                  ),
                ),
      );
      expect(
        secondRuns.length,
        2,
      );
    });
  });
}
