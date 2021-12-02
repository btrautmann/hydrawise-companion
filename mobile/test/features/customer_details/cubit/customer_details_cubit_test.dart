import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irri/core/core.dart';
import 'package:irri/features/auth/auth.dart';
import 'package:irri/features/auth/domain/validate_api_key.dart';
import 'package:irri/features/customer_details/customer_details.dart';

void main() {
  group('CustomerDetailsCubit', () {
    final DataStorage dataStorage = InMemoryStorage();

    late AuthCubit authCubit;

    CustomerDetailsCubit _buildSubject() {
      final repository = InMemoryCustomerDetailsRepository();
      final setApiKey = SetApiKey(dataStorage);
      final setFirebaseUid = SetFirebaseUid(dataStorage);

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

      return CustomerDetailsCubit(
        getCustomerDetails: GetFakeCustomerDetails(
          repository: repository,
        ),
        getCustomerStatus: GetFakeCustomerStatus(
          repository: repository,
        ),
        authCubit: authCubit,
      );
    }

    setUp(() async {
      await dataStorage.clearAll();
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
        blocTest<CustomerDetailsCubit, CustomerDetailsState>(
          'it emits Complete',
          setUp: () async {
            await authCubit.login('fake-api-key');
          },
          build: _buildSubject,
          act: (cubit) => cubit.start(),
          expect: () => <CustomerDetailsState>[
            CustomerDetailsState.loading(),
            CustomerDetailsState.complete(
              customerDetails: CustomerDetails(
                activeControllerId: 1234,
                customerId: 5678,
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
                timeOfLastStatusUnixEpoch: 1631330889,
                zones: [],
              ),
            ),
          ],
        );
      });
    });
  });
}
