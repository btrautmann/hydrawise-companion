import 'package:charlatan/charlatan.dart';
import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irri/core/core.dart';
import 'package:irri/features/auth/auth.dart';
import 'package:irri/features/customer_details/customer_details.dart';

import '../../../core/fakes/fake_http_client.dart';

void main() {
  group('call()', () {
    late GetCustomerStatus subject;
    final storage = InMemoryStorage();
    final repository = InMemoryCustomerDetailsRepository();
    final setApiKey = SetApiKey(storage);
    final setPollTime = SetNextPollTimeInStorage(storage);

    Future<void> _buildSubject(Charlatan charlatan) async {
      final client = FakeHttpClient(charlatan);
      subject = GetCustomerStatus(
        httpClient: client,
        getApiKey: GetApiKey(storage),
        repository: repository,
        getNextPollTime: GetNextPollTimeFromStorage(storage),
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
          lastStatusUpdate: clock.now().millisecondsSinceEpoch,
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
                timeOfLastStatusUnixEpoch: clock.now().millisecondsSinceEpoch,
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

      test('is passes the api key in query parameters', () async {
        await subject.call();
        expect(queryParameters, isNotEmpty);
        expect(queryParameters['api_key'], 'fake-api-key');
      });

      group('when activeControllerId is provided', () {
        test('is passes the controller id in query parameters', () async {
          await subject.call(activeControllerId: 1);
          expect(queryParameters, isNotEmpty);
          expect(queryParameters['controller_id'], '1');
        });
      });

      group('when api call succeeds', () {
        final fixedTime = DateTime(2020);

        test('it returns customer status', () async {
          await withClock(Clock.fixed(fixedTime), () async {
            final result = await subject.call();
            expect(result.isSuccess, isTrue);
            expect(
              result.success,
              CustomerStatus(
                numberOfSecondsUntilNextRequest: 65110146,
                timeOfLastStatusUnixEpoch: 1642964946792,
                zones: [],
              ),
            );
          });
        });

        // test('it updates customer', () async {
        //   final customerBefore = await repository.getCustomer();
        //   expect(customerBefore?.lastStatusUpdate, 0);
        //   await subject.call();
        //   final customerAfter = await repository.getCustomer();
        //   expect(customerAfter, isNotNull);
        // });
      });
    });

    //   group('when api call fails', () {
    //     setUp(() async {
    //       final charlatan = Charlatan()
    //         ..whenGet(
    //           'customerdetails.php',
    //           (request) => CharlatanHttpResponse(statusCode: 500),
    //         );
    //       await _buildSubject(charlatan);
    //     });

    //     test('it returns customer details', () async {
    //       final result = await subject.call();
    //       expect(result.isFailure, isTrue);
    //       expect(
    //         result.failure,
    //         "Can't fetch customer details",
    //       );
    //     });
    //   });
  });
}
