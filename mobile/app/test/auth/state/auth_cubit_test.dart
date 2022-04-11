import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irri/auth/auth.dart';
import 'package:irri/customer_details/customer_details.dart';

void main() {
  group('AuthCubit', () {
    final DataStorage dataStorage = InMemoryStorage();
    final setApiKey = SetApiKey(dataStorage);
    final setFirebaseUid = SetFirebaseUid(dataStorage);

    AuthCubit buildSubject({
      StreamController? authFailures,
      ValidateApiKey? validateApiKey,
      LogIn? logIn,
      LogOut? logOut,
    }) {
      return AuthCubit(
        isLoggedIn: IsLoggedIn(
          getApiKey: GetApiKey(dataStorage),
          getFirebaseUid: GetFirebaseUid(dataStorage),
        ),
        logOut: logOut ??
            LogOut(
              setApiKey: setApiKey,
              unauthenticateWithFirebase: FakeUnauthenticateWithFirebase(
                setFirebaseUid: setFirebaseUid,
              ),
              customerDetailsRepository: InMemoryCustomerDetailsRepository(),
            ),
        getAuthFailures: GetAuthFailures(
          authFailuresController: authFailures ?? StreamController(),
        ),
        logIn: logIn ??
            LogIn(
              validateApiKey: validateApiKey ??
                  FakeValidateApiKey(
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
            build: buildSubject,
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
            build: buildSubject,
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
          build: () => buildSubject(authFailures: authFailures),
          act: (cubit) => authFailures.add(null),
          expect: () => <AuthState>[
            AuthState.loggedOut(),
          ],
        );
      });
    });

    group('validateApiKey', () {
      test('it calls LogIn', () async {
        var logInCalled = false;
        final subject = buildSubject(
          logIn: _FakeLogIn(() {
            logInCalled = true;
          }),
        );

        await subject.validateApiKey('1234');

        expect(logInCalled, isTrue);
      });
    });

    group('logIn', () {
      blocTest<AuthCubit, AuthState>(
        'it emits [loggedIn]',
        build: buildSubject,
        // Skip the initial loggedOut emission
        skip: 1,
        act: (cubit) async => cubit.login('1234'),
        expect: () => <AuthState>[
          AuthState.loggedIn(),
        ],
      );

      test('it calls LogOut if authentication fails', () async {
        var logOutCalled = false;

        final subject = buildSubject(
          validateApiKey: FakeValidateApiKey(
            isValid: false,
            setApiKey: SetApiKey(dataStorage),
          ),
          logOut: _FakeLogOut(() {
            logOutCalled = true;
          }),
        );

        await subject.login('1234');

        expect(logOutCalled, isTrue);
      });
    });
  });
}

class _FakeLogOut implements LogOut {
  _FakeLogOut(this.onCalled);

  final VoidCallback onCalled;

  @override
  Future<void> call() async {
    onCalled();
  }
}

class _FakeLogIn implements LogIn {
  _FakeLogIn(this.onCalled);

  final VoidCallback onCalled;

  @override
  Future<bool> call(String apiKey) async {
    onCalled();
    return true;
  }
}
