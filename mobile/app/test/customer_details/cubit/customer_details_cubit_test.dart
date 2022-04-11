import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:clock/clock.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrawise/hydrawise.dart';
import 'package:irri/auth/auth.dart';
import 'package:irri/customer_details/customer_details.dart';

void main() {
  group('CustomerDetailsCubit', () {
    final DataStorage dataStorage = InMemoryStorage();

    final repository = InMemoryCustomerDetailsRepository();
    final setApiKey = SetApiKey(dataStorage);
    final setFirebaseUid = SetFirebaseUid(dataStorage);
    late AuthCubit authCubit;

    CustomerDetailsCubit _buildSubject() {
      return CustomerDetailsCubit(
        getCustomerDetails: GetFakeCustomerDetails(repository: repository),
        getCustomerStatus: GetFakeCustomerStatus(repository: repository),
        authCubit: authCubit,
      );
    }

    setUp(() async {
      await dataStorage.clearAll();

      authCubit = AuthCubit(
        logOut: LogOut(
          setApiKey: setApiKey,
          unauthenticateWithFirebase: FakeUnauthenticateWithFirebase(
            setFirebaseUid: setFirebaseUid,
          ),
          customerDetailsRepository: repository,
        ),
        getAuthFailures: GetAuthFailures(
          authFailuresController: StreamController(),
        ),
        logIn: LogIn(
          validateApiKey: FakeValidateApiKey(
            setApiKey: setApiKey,
          ),
          authenticateWithFirebase: FakeAuthenticateWithFirebase(
            setFirebaseUid: setFirebaseUid,
          ),
        ),
        isLoggedIn: IsLoggedIn(
          getApiKey: GetApiKey(dataStorage),
          getFirebaseUid: GetFirebaseUid(dataStorage),
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
              customerDetails: CustomerDetails(
                activeControllerId: 1,
                customerId: 1,
                controllers: [
                  Controller(
                    name: 'Fake Controller',
                    lastContact: 1631616496,
                    serialNumber: '123456789',
                    id: 1234,
                    status: 'All good!',
                  )
                ],
              ),
              customerStatus: CustomerStatus(
                numberOfSecondsUntilNextRequest: 5,
                // ignore: lines_longer_than_80_chars
                timeOfLastStatusUnixEpoch:
                    fixedWallClock.now().millisecondsSinceEpoch,
                zones: [],
              ),
            ),
          ],
        );
      });
    });
  });
}