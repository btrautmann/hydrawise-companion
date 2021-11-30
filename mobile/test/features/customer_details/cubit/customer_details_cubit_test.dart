import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irri/core/core.dart';
import 'package:irri/features/auth/auth.dart';
import 'package:irri/features/auth/domain/validate_api_key.dart';
import 'package:irri/features/customer_details/customer_details.dart';

void main() {
  group('CustomerDetailsCubit', () {
    final repository = InMemoryCustomerDetailsRepository();
    final DataStorage dataStorage = InMemoryStorage();

    final GetCustomerStatus getCustomerStatus = GetFakeCustomerStatus(
      repository: repository,
    );
    final GetCustomerDetails getCustomerDetails = GetFakeCustomerDetails(
      repository: repository,
    );

    final getApiKey = GetApiKey(dataStorage);
    final setApiKey = SetApiKey(dataStorage);
    final getAuthFailures = GetAuthFailures(
      authFailuresController: StreamController(),
    );
    final setFirebaseUid = SetFirebaseUid(dataStorage);
    final getFirebaseUid = GetFirebaseUid(dataStorage);
    final logOut = LogOut(
      setApiKey: setApiKey,
      setFirebaseUid: setFirebaseUid,
      customerDetailsRepository: repository,
      auth: MockFirebaseAuth(),
    );

    final authCubit = AuthCubit(
      logOut: logOut,
      getAuthFailures: getAuthFailures,
      logIn: LogIn(
        validateApiKey: FakeValidateApiKey(
          setApiKey: setApiKey,
        ),
        authenticateWithFirebase: FakeAuthenticateWithFirebase(
          setFirebaseUid: setFirebaseUid,
        ),
      ),
      isLoggedIn: IsLoggedIn(
        getApiKey: getApiKey,
        getFirebaseUid: getFirebaseUid,
      ),
    );

    CustomerDetailsCubit _buildSubject() {
      return CustomerDetailsCubit(
        getCustomerDetails: getCustomerDetails,
        getCustomerStatus: getCustomerStatus,
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
