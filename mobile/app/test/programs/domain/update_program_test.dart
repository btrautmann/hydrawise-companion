import 'dart:math';

import 'package:api_models/api_models.dart';
import 'package:charlatan/charlatan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irri/customer_details/customer_details.dart';
import 'package:irri/programs/programs.dart';

import '../../core/fakes/fake_http_client.dart';

void main() {
  group('UpdateProgram', () {
    late CustomerDetailsRepository repository;
    late UpdateProgram updateProgram;
    final charlatan = Charlatan();
    final httpClient = FakeHttpClient(charlatan);
    setUp(() {
      repository = InMemoryCustomerDetailsRepository();
      updateProgram = UpdateProgram(client: httpClient, repository: repository);
      charlatan.whenPut('program', (request) {
        // ignore: cast_nullable_to_non_nullable
        final r = request.body as UpdateProgramRequest;
        return CharlatanHttpResponse(
          body: UpdateProgramResponse(
            program: Program(
              id: r.programId,
              name: r.programName,
              frequency: r.frequency,
              runs: [
                ...r.runs.map(
                  (e) => Run(
                    id: Random().nextInt(100),
                    programId: r.programId,
                    zoneId: e.zoneId,
                    durationSeconds: e.durationSeconds,
                    startHour: e.startHour,
                    startMinute: e.startMinute,
                  ),
                ),
              ],
            ),
          ),
        );
      });
    });
    test('it updates the program name', () async {
      await repository.insertProgram(
        Program(
          id: 12345,
          name: 'Original',
          frequency: [],
          runs: List.empty(),
        ),
      );

      await updateProgram(
        programId: 12345,
        name: 'New',
        frequency: [],
        runGroups: [],
      );

      expect(
        await repository.getProgram(programId: 12345).then((value) => value.name),
        'New',
      );
    });

    test('it updates the program frequency', () async {
      await repository.insertProgram(
        Program(
          id: 12345,
          name: 'Original',
          frequency: [],
          runs: List.empty(),
        ),
      );

      await updateProgram(
        programId: 12345,
        name: 'New',
        frequency: [DateTime.monday],
        runGroups: [],
      );

      expect(
        await repository.getProgram(programId: 12345).then((value) => value.frequency.contains(DateTime.monday)),
        isTrue,
      );
    });

    test('it adds a run when a zone is added', () async {
      await repository.insertProgram(
        Program(
          id: 12345,
          name: 'Original',
          frequency: [],
          runs: List.empty(),
        ),
      );

      final runsBefore = await repository.getRunsForProgram(programId: 12345);
      expect(runsBefore.length, 0);

      final now = TimeOfDay.now();

      await updateProgram(
        programId: 12345,
        name: 'New',
        frequency: [DateTime.monday],
        runGroups: [
          RunCreation(
            zoneId: 1,
            durationSeconds: const Duration(seconds: 5).inSeconds,
            startHour: now.hour,
            startMinute: now.minute,
          ),
        ],
      );

      final runsAfter = await repository.getRunsForProgram(programId: 12345);

      expect(runsAfter.length, 1);
      expect(runsAfter.single.zoneId, 1);
    });

    test('it removes a run when a zone is removed', () async {
      await repository.insertProgram(
        Program(
          id: 12345,
          name: 'Original',
          frequency: [],
          runs: [
            Run(
              id: 1,
              programId: 12345,
              startHour: 9,
              startMinute: 9,
              durationSeconds: 55,
              zoneId: 1,
            ),
            Run(
              id: 2,
              programId: 12345,
              startHour: 9,
              startMinute: 9,
              durationSeconds: 55,
              zoneId: 2,
            ),
          ],
        ),
      );

      final runsBefore = await repository.getRunsForProgram(programId: 12345);
      expect(runsBefore.length, 2);

      final now = TimeOfDay.now();

      await updateProgram(
        programId: 12345,
        name: 'New',
        frequency: [],
        runGroups: [
          RunCreation(
            zoneId: 1,
            durationSeconds: const Duration(seconds: 5).inSeconds,
            startHour: now.hour,
            startMinute: now.minute,
          ),
        ],
      );

      final runsAfter = await repository.getRunsForProgram(programId: 12345);

      expect(runsAfter.length, 1);
      expect(runsAfter.single.zoneId, 1);
    });

    test('it updates start time and duration of existing zones', () async {
      await repository.insertProgram(
        Program(
          id: 12345,
          name: 'Original',
          frequency: [],
          runs: [
            Run(
              id: 1,
              programId: 12345,
              startHour: 9,
              startMinute: 9,
              durationSeconds: 55,
              zoneId: 1,
            ),
          ],
        ),
      );

      final runsBefore = await repository.getRunsForProgram(programId: 12345);
      expect(runsBefore.single.startTime, const TimeOfDay(hour: 9, minute: 9));
      expect(runsBefore.single.durationSeconds, 55);

      final now = TimeOfDay.now();

      await updateProgram(
        programId: 12345,
        name: 'New',
        frequency: [],
        runGroups: [
          RunCreation(
            zoneId: 1,
            durationSeconds: const Duration(seconds: 5).inSeconds,
            startHour: now.hour,
            startMinute: now.minute,
          ),
        ],
      );

      final runsAfter = await repository.getRunsForProgram(programId: 12345);

      expect(runsAfter.single.startTime, const TimeOfDay(hour: 5, minute: 5));
      expect(runsAfter.single.durationSeconds, 25);
    });
  });
}
