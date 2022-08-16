import 'dart:async';

import 'package:api_models/api_models.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:charlatan/charlatan.dart';
import 'package:clock/clock.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irri/auth/auth.dart';
import 'package:irri/configuration/configuration.dart';
import 'package:irri/customer_details/customer_details.dart';

import '../../core/fakes/fake_http_client.dart';

void main() {
  group('CustomerDetailsCubit', () {
    final DataStorage dataStorage = InMemoryStorage();
    final charlatan = Charlatan();
    final repository = InMemoryCustomerDetailsRepository();
    final setApiKey = SetApiKey(dataStorage);
    late AuthCubit authCubit;

    CustomerDetailsCubit _buildSubject() {
      return CustomerDetailsCubit(
        getCustomerDetails: GetCustomerDetails(
          httpClient: FakeHttpClient(charlatan),
          repository: repository,
        ),
        setNextPollTime: SetNextPollTimeInStorage(dataStorage),
        getNextPollTime: GetNextPollTimeFromStorage(dataStorage),
        authCubit: authCubit,
      );
    }

    setUp(() async {
      await dataStorage.clearAll();
      final customer = Customer(
        activeControllerId: 1,
        customerId: 1,
      );

      charlatan
        ..whenGet(
          'customer',
          (request) => GetCustomerResponse(
            customer: customer,
            zones: [
              Zone(
                id: 1,
                number: 1,
                name: 'Fake zone',
                nextRunStart: '2022-08-16T18:02:02.249812',
                nextRunLengthSec: 60,
                isRunning: false,
                timeRemainingSec: 0,
              ),
            ],
          ),
        )
        ..whenPost(
          'login',
          (request) => CharlatanHttpResponse(
            body: customer,
          ),
        );

      authCubit = AuthCubit(
        logOut: LogOut(
          setApiKey: setApiKey,
          customerDetailsRepository: repository,
        ),
        getAuthFailures: GetAuthFailures(
          authFailuresController: StreamController(),
        ),
        logIn: LogIn(
          httpClient: FakeHttpClient(charlatan),
          setApiKey: setApiKey,
        ),
        isLoggedIn: IsLoggedIn(
          getApiKey: GetApiKey(dataStorage),
        ),
        getLocalTimezone: FakeGetLocalTimezone(),
      );
    });

    group('start', () {
      group('when logged out', () {
        blocTest<CustomerDetailsCubit, CustomerDetailsState>(
          'it emits nothing',
          build: _buildSubject,
          act: (cubit) => cubit.start(),
          expect: () => <CustomerDetailsState>[],
        );
      });

      group('when logged in', () {
        // Uses a fixed wall-clock because customer status
        // uses the current time for `timeOfLastStatusUnixEpoch`
        final fixedWallClock = Clock.fixed(DateTime(2020));
        blocTest<CustomerDetailsCubit, CustomerDetailsState>(
          'it emits Complete',
          setUp: () async {
            await authCubit.login('fake-api-key');
          },
          build: _buildSubject,
          act: (cubit) async {
            // Use fixed clock for the `act` zone
            await withClock(fixedWallClock, () async {
              await cubit.start();
            });
          },
          expect: () => <CustomerDetailsState>[
            CustomerDetailsState.loading(),
            CustomerDetailsState.complete(
              customerDetails: Customer(
                activeControllerId: 1,
                customerId: 1,
              ),
              zones: [
                Zone(
                  id: 1,
                  number: 1,
                  name: 'Fake zone',
                  nextRunStart: '2022-08-16T18:02:02.249812',
                  nextRunLengthSec: 60,
                  isRunning: false,
                  timeRemainingSec: 0,
                ),
              ],
            ),
          ],
        );
      });
    });
  });
}
