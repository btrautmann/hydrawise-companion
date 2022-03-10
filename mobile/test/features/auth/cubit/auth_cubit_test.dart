import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irri/core/core.dart';
import 'package:irri/features/auth/auth.dart';
import 'package:irri/features/customer_details/customer_details.dart';

void main() {
  group('AuthCubit', () {
    final DataStorage dataStorage = InMemoryStorage();
    final setApiKey = SetApiKey(dataStorage);
    final setFirebaseUid = SetFirebaseUid(dataStorage);

    AuthCubit _buildSubject({
      StreamController? authFailures,
    }) {
      return AuthCubit(
        isLoggedIn: IsLoggedIn(
          getApiKey: GetApiKey(dataStorage),
          getFirebaseUid: GetFirebaseUid(dataStorage),
        ),
        logOut: LogOut(
          setApiKey: setApiKey,
          unauthenticateWithFirebase: FakeUnauthenticateWithFirebase(
            setFirebaseUid: setFirebaseUid,
          ),
          customerDetailsRepository: InMemoryCustomerDetailsRepository(),
        ),
        getAuthFailures: GetAuthFailures(
          authFailuresController: authFailures ?? StreamController(),
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
      group('checkAuthenticationStatus', () {
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
      group('listenForAuthFailures', () {
        // ignore: close_sinks, prefer_void_to_null
        final authFailures = StreamController<Null>();
        blocTest<AuthCubit, AuthState>(
          'it logs out and emits [loggedOut]',
          build: () => _buildSubject(authFailures: authFailures),
          act: (cubit) => authFailures.add(null),
          expect: () => <AuthState>[
            AuthState.loggedOut(),
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
  });
}
