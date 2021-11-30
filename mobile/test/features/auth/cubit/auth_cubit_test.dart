import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irri/core/core.dart';
import 'package:irri/features/auth/auth.dart';
import 'package:irri/features/auth/domain/validate_api_key.dart';
import 'package:irri/features/customer_details/customer_details.dart';

void main() {
  group('AuthCubit', () {
    final DataStorage dataStorage = InMemoryStorage();
    final getApiKey = GetApiKey(dataStorage);
    final setApiKey = SetApiKey(dataStorage);
    final setFirebaseUid = SetFirebaseUid(dataStorage);
    final getFirebaseUid = GetFirebaseUid(dataStorage);
    final authenticateWithFirebase = AuthenticateWithFirebase(
      firestore: FakeFirebaseFirestore(),
      auth: MockFirebaseAuth(),
      setFirebaseUid: setFirebaseUid,
    );

    final repository = InMemoryCustomerDetailsRepository();
    late GetAuthFailures getAuthFailures;

    setUp(() {
      getAuthFailures = GetAuthFailures(
        authFailuresController: StreamController(),
      );
    });

    AuthCubit _buildSubject() {
      return AuthCubit(
        isLoggedIn: IsLoggedIn(
          getApiKey: getApiKey,
          getFirebaseUid: getFirebaseUid,
        ),
        logOut: LogOut(
          setApiKey: setApiKey,
          setFirebaseUid: setFirebaseUid,
          customerDetailsRepository: repository,
          auth: MockFirebaseAuth(),
        ),
        getAuthFailures: getAuthFailures,
        logIn: LogIn(
          validateApiKey: FakeValidateApiKey(
            setApiKey: setApiKey,
          ),
          authenticateWithFirebase: authenticateWithFirebase,
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
        skip: 1, // Initial check
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
