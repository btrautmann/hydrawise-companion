import 'dart:async';

import 'package:api_models/api_models.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:charlatan/charlatan.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irri/auth/auth.dart';
import 'package:irri/configuration/configuration.dart';
import 'package:irri/customer_details/customer_details.dart';

import '../../core/fakes/fake_http_client.dart';

void main() {
  group('AuthCubit', () {
    final charlatan = Charlatan();
    final DataStorage dataStorage = InMemoryStorage();
    final setApiKey = SetApiKey(dataStorage);

    AuthCubit buildSubject({
      StreamController? authFailures,
      LogIn? logIn,
      LogOut? logOut,
    }) {
      return AuthCubit(
        isLoggedIn: IsLoggedIn(
          getApiKey: GetApiKey(dataStorage),
        ),
        logOut: logOut ??
            LogOut(
              setApiKey: setApiKey,
              customerDetailsRepository: InMemoryCustomerDetailsRepository(),
            ),
        getAuthFailures: GetAuthFailures(
          authFailuresController: authFailures ?? StreamController(),
        ),
        logIn: logIn ??
            LogIn(
              httpClient: FakeHttpClient(charlatan),
              setApiKey: setApiKey,
            ),
        getLocalTimezone: FakeGetLocalTimezone(),
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

    group('logIn', () {
      blocTest<AuthCubit, AuthState>(
        'it emits [loggedIn]',
        build: buildSubject,
        setUp: () {
          charlatan.whenPost(
            'login',
            (request) => CharlatanHttpResponse(
              body: LoginResponse(
                customer: Customer(
                  activeControllerId: 1,
                  customerId: 1,
                ),
              ),
            ),
          );
        },
        // Skip the initial loggedOut emission
        skip: 1,
        act: (cubit) async => cubit.login('1234'),
        expect: () => <AuthState>[
          AuthState.loggedIn(),
        ],
      );

      test('it calls LogOut if authentication fails', () async {
        charlatan.whenPost(
          'login',
          (request) => CharlatanHttpResponse(
            statusCode: 401,
          ),
        );

        var logOutCalled = false;

        final subject = buildSubject(
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
