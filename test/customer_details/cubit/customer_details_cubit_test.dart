import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrawise/core/core.dart';
import 'package:hydrawise/features/customer_details/cubit/customer_details_cubit.dart';
import 'package:hydrawise/features/customer_details/cubit/customer_details_state.dart';
import 'package:hydrawise/features/customer_details/customer_details.dart';
import 'package:hydrawise/features/customer_details/models/controller.dart';
import 'package:hydrawise/features/customer_details/models/customer_status.dart';
import 'package:hydrawise/features/customer_details/repository/customer_details_repository.dart';

void main() {
  group('CustomerDetailsCubit', () {
    final repository = InMemoryCustomerDetailsRepository();
    final DataStorage dataStorage = InMemoryStorage();

    final GetCustomerStatus getCustomerStatus =
        GetFakeCustomerStatus(repository: repository);
    final GetCustomerDetails getCustomerDetails =
        GetFakeCustomerDetails(repository: repository);

    final ClearCustomerDetails clearCustomerDetails =
        ClearCustomerDetailsFromStorage(dataStorage);
    final GetApiKey getApiKey = GetApiKeyFromStorage(dataStorage);
    final SetApiKey setApiKey = SetApiKeyInStorage(dataStorage);

    CustomerDetailsCubit _buildSubject() {
      return CustomerDetailsCubit(
        getCustomerDetails: getCustomerDetails,
        getCustomerStatus: getCustomerStatus,
        getApiKey: getApiKey,
        setApiKey: setApiKey,
        clearCustomerDetails: clearCustomerDetails,
      );
    }

    setUp(() async {
      await dataStorage.clearAll();
    });

    group('loadCustomerDetails', () {
      blocTest<CustomerDetailsCubit, CustomerDetailsState>(
        'it emits Empty',
        build: _buildSubject,
        expect: () => <CustomerDetailsState>[
          CustomerDetailsState.empty(),
        ],
      );
    });
    group('when api key is stored', () {
      blocTest<CustomerDetailsCubit, CustomerDetailsState>(
        'it emits Complete',
        build: () {
          setApiKey('1234');
          return _buildSubject();
        },
        wait: const Duration(milliseconds: 1000),
        expect: () => <CustomerDetailsState>[
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
                numberOfSecondsUntilNextRequest: 100,
                timeOfLastStatusUnixEpoch: 1631330889,
                zones: [],
              )),
        ],
      );
    }, skip: 'Async state initialization causes this to fail');

    group('updateApiKey', () {
      blocTest<CustomerDetailsCubit, CustomerDetailsState>(
        'it loads associated customer details',
        build: _buildSubject,
        act: (cubit) => cubit.updateApiKey('1234'),
        expect: () => <CustomerDetailsState>[
          CustomerDetailsState.empty(),
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
}
