import 'package:core/core.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irri/auth/auth.dart';

void main() {
  group('UnauthenticateWithFirebase.', () {
    late UnauthenticateWithFirebase subject;
    final firebaseAuth = MockFirebaseAuth(
      signedIn: true,
    );
    final storage = InMemoryStorage();
    final setFirebaseUid = SetFirebaseUid(storage);

    setUp(() async {
      await setFirebaseUid('fake-uid');
    });

    test(
        'it clears the firebase uid and '
        'unauthenticates with firebase', () async {
      subject = UnauthenticateWithFirebase(
        firebaseAuth: firebaseAuth,
        setFirebaseUid: setFirebaseUid,
      );

      final getFirebaseUid = GetFirebaseUid(storage);
      expect(await getFirebaseUid(), isNotEmpty);
      expect(firebaseAuth.currentUser, isNotNull);

      await subject.call();

      expect(await getFirebaseUid(), isEmpty);
      expect(firebaseAuth.currentUser, isNull);
    });
  });
}
