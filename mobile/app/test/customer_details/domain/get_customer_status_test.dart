import 'package:charlatan/charlatan.dart';
import 'package:clock/clock.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrawise/hydrawise.dart';
import 'package:irri/auth/auth.dart';
import 'package:irri/customer_details/customer_details.dart';

import '../../core/fakes/fake_http_client.dart';

void main() {
  group('call()', () {
    late GetCustomerStatus subject;
    final storage = InMemoryStorage();
    final repository = InMemoryCustomerDetailsRepository();
    final setApiKey = SetApiKey(storage);
    final setPollTime = SetNextPollTimeInStorage(storage);
    final getPollTime = GetNextPollTimeFromStorage(storage);
    final fixedTime = DateTime(2020);

    Future<void> _buildSubject(Charlatan charlatan) async {
      final client = FakeHttpClient(charlatan);
      subject = GetCustomerStatus(
        httpClient: client,
        getApiKey: GetApiKey(storage),
        repository: repository,
        getNextPollTime: getPollTime,
        setNextPollTime: setPollTime,
      );
    }

    setUp(() async {
      await storage.clearAll();
      await repository.clearAllData();
      await setApiKey('fake-api-key');

      await repository.insertCustomer(
        Customer(
          activeControllerId: 1,
          customerId: 1,
          apiKey: 'fake-api-key',
          lastStatusUpdate: 0,
        ),
      );
    });

    group('when next poll time has passed', () {
      var apiPolled = false;
      late Map<String, Object?> queryParameters;

      setUp(() async {
        await setPollTime(secondsUntilNextPoll: 0);
        final charlatan = Charlatan()
          ..whenGet(
            'statusschedule.php',
            (request) {
              apiPolled = true;
              queryParameters = request.queryParameters;
              return CustomerStatus(
                numberOfSecondsUntilNextRequest: 5,
                timeOfLastStatusUnixEpoch: fixedTime.millisecondsSinceEpoch,
                zones: [],
              );
            },
          );
        await _buildSubject(charlatan);
      });
      test('it polls the api', () async {
        await subject.call();
        expect(apiPolled, isTrue);
      });

      test('it passes the api key in query parameters', () async {
        await subject.call();
        expect(queryParameters, isNotEmpty);
        expect(queryParameters['api_key'], 'fake-api-key');
      });

      group('when activeControllerId is provided', () {
        test('it passes the controller id in query parameters', () async {
          await subject.call(activeControllerId: 1);
          expect(queryParameters, isNotEmpty);
          expect(queryParameters['controller_id'], '1');
        });
      });

      group('when api call succeeds', () {
        test('it returns customer status', () async {
          final result = await subject.call();
          expect(result.isSuccess, isTrue);
          expect(
            result.success,
            CustomerStatus(
              numberOfSecondsUntilNextRequest: 5,
              timeOfLastStatusUnixEpoch: fixedTime.millisecondsSinceEpoch,
              zones: [],
            ),
          );
        });

        test('it updates customer', () async {
          final customerBefore = await repository.getCustomer();
          expect(customerBefore?.lastStatusUpdate, 0);
          await subject.call();
          final customerAfter = await repository.getCustomer();
          expect(
            customerAfter?.lastStatusUpdate,
            fixedTime.millisecondsSinceEpoch,
          );
        });

        test('it sets next poll time', () async {
          final nextPollTimeBefore = await getPollTime();
          await subject.call();
          final nextPollTimeAfter = await getPollTime();
          expect(nextPollTimeAfter.isAfter(nextPollTimeBefore), isTrue);
        });
      });

      group('when api call fails', () {
        setUp(() async {
          final charlatan = Charlatan()
            ..whenGet(
              'statusschedule.php',
              (request) => CharlatanHttpResponse(statusCode: 500),
            );
          await _buildSubject(charlatan);
        });

        group('when it hits the cache', () {
          group('when cache hit succeeds', () {
            test('it returns a success with customer status', () async {
              await withClock(Clock.fixed(DateTime.now()), () async {
                // Set the poll time based on a fixed time
                await setPollTime(secondsUntilNextPoll: 0);
                final result = await subject.call();
                expect(result.isSuccess, isTrue);
                expect(
                  result.success,
                  CustomerStatus(
                    numberOfSecondsUntilNextRequest: 0,
                    timeOfLastStatusUnixEpoch: 0,
                    zones: [],
                  ),
                );
              });
            });
          });

          group('when cache hit fails', () {
            test('it returns a failure', () async {
              await repository.clearAllData();
              final result = await subject.call();
              expect(result.isFailure, isTrue);
              expect(result.failure, "Can't fetch customer status");
            });
          });
        });
      });
    });
  });
}
