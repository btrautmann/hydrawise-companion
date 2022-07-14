import 'dart:async';

import 'package:api_models/api_models.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:charlatan/charlatan.dart';
import 'package:clock/clock.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irri/auth/auth.dart';
import 'package:irri/customer_details/customer_details.dart';

import '../../core/fakes/fake_http_client.dart';

void main() {
  group('CustomerDetailsCubit', () {
    final DataStorage dataStorage = InMemoryStorage();

    final repository = InMemoryCustomerDetailsRepository();
    final setApiKey = SetApiKey(dataStorage);
    late AuthCubit authCubit;

    CustomerDetailsCubit _buildSubject() {
      return CustomerDetailsCubit(
        getCustomerDetails: GetCustomerDetails(
          httpClient: FakeHttpClient(Charlatan()),
          getApiKey: GetApiKey(dataStorage),
          repository: repository,
        ),
        setNextPollTime: SetNextPollTimeInStorage(dataStorage),
        getNextPollTime: GetNextPollTimeFromStorage(dataStorage),
        authCubit: authCubit,
      );
    }

    setUp(() async {
      await dataStorage.clearAll();

      authCubit = AuthCubit(
        logOut: LogOut(
          setApiKey: setApiKey,
          customerDetailsRepository: repository,
        ),
        getAuthFailures: GetAuthFailures(
          authFailuresController: StreamController(),
        ),
        logIn: LogIn(
          validateApiKey: FakeValidateApiKey(
            setApiKey: setApiKey,
          ),
        ),
        isLoggedIn: IsLoggedIn(
          getApiKey: GetApiKey(dataStorage),
        ),
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
          act: (cubit) {
            // Use fixed clock for the `act` zone
            withClock(fixedWallClock, () {
              cubit.start();
            });
          },
          expect: () => <CustomerDetailsState>[
            CustomerDetailsState.loading(),
            CustomerDetailsState.complete(
              customerDetails: Customer(
                activeControllerId: 1,
                apiKey: 'fake-api-key',
                customerId: 1,
              ),
              zones: List.empty(),
            ),
          ],
        );
      });
    });
  });
}
