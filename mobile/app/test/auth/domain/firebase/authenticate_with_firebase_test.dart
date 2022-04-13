import 'package:clock/clock.dart';
import 'package:core/core.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irri/auth/auth.dart';

void main() {
  group('AuthenticateWithFirebase.', () {
    late AuthenticateWithFirebase subject;
    final firestore = FakeFirebaseFirestore();
    final storage = InMemoryStorage();

    setUp(storage.clearAll);

    test('it stores the authentication time in firestore', () async {
      subject = AuthenticateWithFirebase(
        firestore: firestore,
        auth: MockFirebaseAuth(
          mockUser: MockUser(
            isAnonymous: true,
            uid: 'fake-uid',
          ),
        ),
        setFirebaseUid: SetFirebaseUid(storage),
      );

      await withClock(Clock.fixed(DateTime.now()), () async {
        await subject.call();

        final storedUser =
            await firestore.collection('users').doc('fake-uid').get();

        // ignore: cast_nullable_to_non_nullable
        final data = storedUser.data() as Map<String, dynamic>;

        expect(
          data['authentication_time'] as String,
          clock.now().toString(),
        );
      });
    });

    test('it sets the firebase uid in storage', () async {
      subject = AuthenticateWithFirebase(
        firestore: firestore,
        auth: MockFirebaseAuth(
          mockUser: MockUser(
            isAnonymous: true,
            uid: 'fake-uid',
          ),
        ),
        setFirebaseUid: SetFirebaseUid(storage),
      );

      await subject.call();

      final getFirebaseUid = GetFirebaseUid(storage);
      expect(
        await getFirebaseUid(),
        'fake-uid',
      );
    });
  });
}
