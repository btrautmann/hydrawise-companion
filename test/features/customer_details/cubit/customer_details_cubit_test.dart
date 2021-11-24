import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrawise/core/core.dart';
import 'package:hydrawise/features/auth/auth.dart';
import 'package:hydrawise/features/customer_details/customer_details.dart';

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

    final setApiKey = SetApiKey(dataStorage);
    final getAuthFailures = GetAuthFailures(
      authFailuresController: StreamController(),
    );
    final setFirebaseUid = SetFirebaseUid(dataStorage);
    final getFirebaseUid = GetFirebaseUid(dataStorage);
    final clearCustomerDetails = ClearCustomerDetails(
      setApiKey: setApiKey,
      setFirebaseUid: setFirebaseUid,
      customerDetailsRepository: repository,
    );

    final authCubit = AuthCubit(
      getApiKey: GetApiKey(dataStorage),
      setApiKey: setApiKey,
      getCustomerDetails: getCustomerDetails,
      clearCustomerDetails: clearCustomerDetails,
      getAuthFailures: getAuthFailures,
      authenticateWithFirebase: AuthenticateWithFirebase(
        firestore: FakeFirebaseFirestore(),
        auth: MockFirebaseAuth(),
      ),
      setFirebaseUid: setFirebaseUid,
      getFirebaseUid: getFirebaseUid,
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
