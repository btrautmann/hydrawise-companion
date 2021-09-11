import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrawise/core/core.dart';
import 'package:hydrawise/customer_details/cubit/customer_details_cubit.dart';
import 'package:hydrawise/customer_details/cubit/customer_details_state.dart';
import 'package:hydrawise/customer_details/customer_details.dart';

void main() {
  group('CustomerDetailsCubit', () {
    final DataStorage dataStorage = InMemoryStorage();
    final GetCustomerDetails getCustomerDetails = GetFakeCustomerDetails();
    final ClearCustomerDetails clearCustomerDetails =
        ClearCustomerDetailsFromStorage(dataStorage);
    final GetApiKey getApiKey = GetApiKeyFromStorage(dataStorage);
    final SetApiKey setApiKey = SetApiKeyInStorage(dataStorage);

    CustomerDetailsCubit _buildSubject() {
      return CustomerDetailsCubit(
        getCustomerDetails: getCustomerDetails,
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
        expect: () => <CustomerDetailsState>[
          CustomerDetailsState.complete(
            customerDetails: CustomerDetails(
              controllerId: 1234,
              customerId: 5678,
            ),
          ),
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
              controllerId: 1234,
              customerId: 5678,
            ),
          ),
        ],
      );
    });
  });
}
