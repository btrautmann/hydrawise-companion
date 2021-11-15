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

      final runs = await repository.getRunsForProgram(programId: programId);

      expect(runs.single.zoneId, 1);
    });
  });
}
