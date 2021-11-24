import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrawise/core/core.dart';
import 'package:hydrawise/features/auth/auth.dart';
import 'package:hydrawise/features/customer_details/customer_details.dart';

void main() {
  group('AuthCubit', () {
    final DataStorage dataStorage = InMemoryStorage();
    final getApiKey = GetApiKey(dataStorage);
    final setApiKey = SetApiKey(dataStorage);
    final setFirebaseUid = SetFirebaseUid(dataStorage);
    final getFirebaseUid = GetFirebaseUid(dataStorage);
    final authenticateWithFirebase =
        AuthenticateWithFirebase(FakeFirebaseFirestore(), MockFirebaseAuth());

    final repository = InMemoryCustomerDetailsRepository();
    final GetCustomerDetails getCustomerDetails = GetFakeCustomerDetails(
      repository: repository,
    );
    late GetAuthFailures getAuthFailures;

    setUp(() {
      getAuthFailures = GetAuthFailures(
        authFailuresController: StreamController(),
      );
    });

    AuthCubit _buildSubject() {
      return AuthCubit(
        getApiKey: getApiKey,
        setApiKey: setApiKey,
        getCustomerDetails: getCustomerDetails,
        clearCustomerDetails: ClearCustomerDetails(
          setApiKey: setApiKey,
          setFirebaseUid: setFirebaseUid,
          customerDetailsRepository: repository,
        ),
        getAuthFailures: getAuthFailures,
        authenticateWithFirebase: authenticateWithFirebase,
        setFirebaseUid: setFirebaseUid,
        getFirebaseUid: getFirebaseUid,
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
