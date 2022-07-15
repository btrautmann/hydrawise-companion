import 'package:api_models/api_models.dart';
import 'package:charlatan/charlatan.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irri/auth/auth.dart';
import 'package:irri/customer_details/repository/repository.dart';
import 'package:irri/programs/programs.dart';

import '../../core/fakes/fake_http_client.dart';

void main() {
  group('CreateProgram', () {
    final repository = InMemoryCustomerDetailsRepository();
    final storage = InMemoryStorage();
    final setApiKey = SetApiKey(storage);
    final charlatan = Charlatan();

    setUp(() async {
      await repository.clearAllData();
      await setApiKey('fake-api-key');
    });

    test('it creates a program with the name and frequency', () async {
      charlatan.whenPost(
        'program',
        (request) => CharlatanHttpResponse(
          body: CreateProgramResponse(
            program: Program(
              id: '12345',
              name: 'Test Program',
              frequency: [1, 2, 3, 4, 5],
              runs: List.empty(),
            ),
          ),
        ),
      );

      final subject = CreateProgram(
        httpClient: FakeHttpClient(charlatan),
        getApiKey: GetApiKey(storage),
        repository: repository,
      );

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
      final time = DateTime.now();

      charlatan.whenPost(
        'program',
        (request) => CharlatanHttpResponse(
          body: CreateProgramResponse(
            program: Program(
              id: '12345',
              name: 'Test Program',
              frequency: [1, 2, 3, 4, 5],
              runs: [
                Run(
                  id: '12345',
                  programId: '12345',
                  zoneId: 0,
                  durationSeconds: 600,
                  startHour: time.hour,
                  startMinute: time.minute,
                ),
                Run(
                  id: '12345',
                  programId: '12345',
                  zoneId: 1,
                  durationSeconds: 600,
                  startHour: time.hour,
                  startMinute: time.minute,
                )
              ],
            ),
          ),
        ),
      );

      final subject = CreateProgram(
        httpClient: FakeHttpClient(charlatan),
        getApiKey: GetApiKey(storage),
        repository: repository,
      );

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
        ],
      );

      final programs = await repository.getPrograms();
      final runs = List.of(programs.single.runs)
        ..sort(
          (a, b) => a.zoneId.compareTo(b.zoneId),
        );

      expect(runs.length, 2);
      expect(runs.first.zoneId, 0);
      expect(runs.last.zoneId, 1);
      expect(
        runs.every(
          (run) => run.startTime == TimeOfDay.fromDateTime(time),
        ),
        isTrue,
      );
      expect(
        runs.every(
          (element) => element.durationSeconds == 600,
        ),
        isTrue,
      );
    });
  });
}
