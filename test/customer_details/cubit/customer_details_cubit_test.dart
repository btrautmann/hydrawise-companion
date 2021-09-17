import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrawise/app/domain/create_database.dart';
import 'package:hydrawise/core/core.dart';
import 'package:hydrawise/customer_details/cubit/customer_details_cubit.dart';
import 'package:hydrawise/customer_details/cubit/customer_details_state.dart';
import 'package:hydrawise/customer_details/customer_details.dart';
import 'package:hydrawise/customer_details/models/controller.dart';
import 'package:hydrawise/customer_details/models/customer_status.dart';
import 'package:sqflite/sqlite_api.dart';

void main() {
  group('CustomerDetailsCubit', () {
    late Database database;
    late GetCustomerStatus getCustomerStatus;
    late GetCustomerDetails getCustomerDetails;
    final DataStorage dataStorage = InMemoryStorage();

    final ClearCustomerDetails clearCustomerDetails =
        ClearCustomerDetailsFromStorage(dataStorage);
    final GetApiKey getApiKey = GetApiKeyFromStorage(dataStorage);
    final SetApiKey setApiKey = SetApiKeyInStorage(dataStorage);

    CustomerDetailsCubit _buildSubject() {
      getCustomerStatus = GetFakeCustomerStatus(database: database);
      getCustomerDetails = GetFakeCustomerDetails(database: database);
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

      database = await CreateHydrawiseDatabase().call(
        databaseName: 'in_memory.db',
        version: 1,
      );
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
    });

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
              numberOfSecondsUntilNextRequest: 100,
              timeOfLastStatusUnixEpoch: 1631330889,
              zones: [],
            ),
          ),
        ],
      );
    });
  }, skip: 'Database requires real device.');
}
