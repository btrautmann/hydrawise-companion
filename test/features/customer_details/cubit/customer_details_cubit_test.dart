import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrawise/core/core.dart';
import 'package:hydrawise/features/customer_details/customer_details.dart';
import 'package:hydrawise/features/login/login.dart';

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
    final clearCustomerDetails = ClearCustomerDetailsFromStorage(
      dataStorage: dataStorage,
      customerDetailsRepository: repository,
    );

    final SetApiKey setApiKey = SetApiKeyInStorage(dataStorage);
    final GetAuthFailures getAuthFailures = GetNetworkAuthFailures(
      authFailuresController: StreamController(),
    );

    final LoginCubit loginCubit = LoginCubit(
      getApiKey: GetApiKeyFromStorage(dataStorage),
      setApiKey: setApiKey,
      getCustomerDetails: getCustomerDetails,
      clearCustomerDetails: clearCustomerDetails,
      getAuthFailures: getAuthFailures,
    );

    CustomerDetailsCubit _buildSubject() {
      return CustomerDetailsCubit(
        getCustomerDetails: getCustomerDetails,
        getCustomerStatus: getCustomerStatus,
        loginCubit: loginCubit,
      );
    }

    setUp(() async {
      await dataStorage.clearAll();
    });

    group('start', () {
      group('when logged out', () {
        blocTest<CustomerDetailsCubit, CustomerDetailsState>(
          'it emits nothing',
          build: () => _buildSubject(),
          act: (cubit) => cubit.start(),
          expect: () => <CustomerDetailsState>[],
        );
      });

      group('when logged in', () {
        blocTest<CustomerDetailsCubit, CustomerDetailsState>(
          'it emits Complete',
          setUp: () async {
            await loginCubit.login('fake-api-key');
          },
          build: () => _buildSubject(),
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
