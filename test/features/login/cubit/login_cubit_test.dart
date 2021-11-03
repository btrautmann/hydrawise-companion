import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrawise/core/core.dart';
import 'package:hydrawise/features/customer_details/customer_details.dart';
import 'package:hydrawise/features/login/cubit/login_cubit.dart';
import 'package:hydrawise/features/login/login.dart';

void main() {
  group('LoginCubit', () {
    final DataStorage dataStorage = InMemoryStorage();
    final GetApiKey getApiKey = GetApiKeyFromStorage(dataStorage);
    final SetApiKey setApiKey = SetApiKeyInStorage(dataStorage);

    final repository = InMemoryCustomerDetailsRepository();
    final GetCustomerDetails getCustomerDetails = GetFakeCustomerDetails(repository: repository);

    LoginCubit _buildSubject() {
      return LoginCubit(
        getApiKey: getApiKey,
        setApiKey: setApiKey,
        getCustomerDetails: getCustomerDetails,
        clearCustomerDetails: ClearCustomerDetailsFromStorage(
          dataStorage: dataStorage,
          customerDetailsRepository: repository,
        ),
      );
    }

    setUp(() async {
      await dataStorage.clearAll();
    });

    group('init', () {
      group('when not logged in', () {
        blocTest<LoginCubit, LoginState>(
          'it emits [loggedOut]',
          build: () => _buildSubject(),
          expect: () => <LoginState>[
            LoginState.loggedOut(),
          ],
        );
      });

      group('when logged in', () {
        blocTest<LoginCubit, LoginState>(
          'it emits [loggedIn]',
          setUp: () async => await setApiKey('1234'),
          build: () => _buildSubject(),
          expect: () => <LoginState>[
            LoginState.loggedIn(apiKey: '1234'),
          ],
        );
      });
    });

    group('logIn', () {
      blocTest<LoginCubit, LoginState>(
        'it emits [loggedIn]',
        build: () => _buildSubject(),
        act: (cubit) async => await cubit.login('1234'),
        skip: 1, // Initial check
        expect: () => <LoginState>[
          LoginState.loggedIn(apiKey: '1234'),
        ],
      );
    });

    group('logOut', () {
      blocTest<LoginCubit, LoginState>(
        'it emits [loggedOut]',
        setUp: () async => await setApiKey('1234'),
        build: () => _buildSubject(),
        act: (cubit) async => await cubit.logOut(),
        skip: 1, // Initial check
        expect: () => <LoginState>[
          LoginState.loggedOut(),
        ],
      );
    });
  });
}
