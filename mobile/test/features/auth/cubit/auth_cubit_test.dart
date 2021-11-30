import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irri/core/core.dart';
import 'package:irri/features/auth/auth.dart';
import 'package:irri/features/auth/domain/validate_api_key.dart';
import 'package:irri/features/customer_details/customer_details.dart';

void main() {
  group('AuthCubit', () {
    final DataStorage dataStorage = InMemoryStorage();
    final setApiKey = SetApiKey(dataStorage);
    final setFirebaseUid = SetFirebaseUid(dataStorage);

    AuthCubit _buildSubject() {
      return AuthCubit(
        isLoggedIn: IsLoggedIn(
          getApiKey: GetApiKey(dataStorage),
          getFirebaseUid: GetFirebaseUid(dataStorage),
        ),
        logOut: FakeLogOut(
          customerDetailsRepository: InMemoryCustomerDetailsRepository(),
          setApiKey: setApiKey,
          setFirebaseUid: setFirebaseUid,
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
      );
    }

    setUp(() async {
      await dataStorage.clearAll();
    });

    group('init', () {
      group('when not logged in', () {
        blocTest<AuthCubit, AuthState>(
          'it emits [loggedOut]',
          build: _buildSubject,
          expect: () => <AuthState>[
            AuthState.loggedOut(),
          ],
        );
      });

      group('when logged in', () {
        blocTest<AuthCubit, AuthState>(
          'it emits [loggedIn]',
          setUp: () async {
            await setApiKey('1234');
            await setFirebaseUid('1');
          },
          build: _buildSubject,
          expect: () => <AuthState>[
            AuthState.loggedIn(),
          ],
        );
      });
    });

    group('logIn', () {
      blocTest<AuthCubit, AuthState>(
        'it emits [loggedIn]',
        build: _buildSubject,
        act: (cubit) async => cubit.login('1234'),
        skip: 1,
        expect: () => <AuthState>[
          AuthState.loggedIn(),
        ],
      );
    });

    group('logOut', () {
      blocTest<AuthCubit, AuthState>(
        'it emits [loggedOut]',
        setUp: () async {
          await setApiKey('1234');
          await setFirebaseUid('1');
        },
        build: _buildSubject,
        act: (cubit) async => cubit.logOut(),
        skip: 1, // Initial check
        expect: () => <AuthState>[
          AuthState.loggedOut(),
        ],
      );
    });
  });
}
