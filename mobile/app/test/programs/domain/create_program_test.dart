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

    setUp(repository.clearAllData);

    test('it creates a program with the name and frequency', () async {
      final subject = CreateProgram(
        httpClient: FakeHttpClient(Charlatan()),
        getApiKey: GetApiKey(InMemoryStorage()),
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
      final subject = CreateProgram(
        httpClient: FakeHttpClient(Charlatan()),
        getApiKey: GetApiKey(InMemoryStorage()),
        repository: repository,
      );

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
        ],
      );

      final programs = await repository.getPrograms();
      final runs = programs.single.runs
        ..sort(
          (a, b) => a.zoneId.compareTo(b.zoneId),
        );

      expect(runs.length, 2);
      expect(runs.first.zoneId, 0);
      expect(runs.last.zoneId, 1);
      expect(
        runs.every(
          (run) =>
              run.startTime ==
              TimeOfDay.fromDateTime(time),
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
