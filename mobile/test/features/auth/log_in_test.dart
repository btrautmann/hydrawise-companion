import 'package:flutter_test/flutter_test.dart';
import 'package:irri/core/core.dart';
import 'package:irri/features/auth/auth.dart';

void main() {
  group('LogIn', () {
    late ValidateApiKey validateApiKey;
    late AuthenticateWithFirebase authenticateWithFirebase;
    final storage = InMemoryStorage();
    final setFirebaseUid = SetFirebaseUid(storage);
    final setApiKey = SetApiKey(storage);
    late LogIn subject;

    setUp(storage.clearAll);

    group('when api key is valid and firebase authentication succeeds', () {
      setUp(() {
        validateApiKey = FakeValidateApiKey(setApiKey: setApiKey);
        authenticateWithFirebase = FakeAuthenticateWithFirebase(
          setFirebaseUid: setFirebaseUid,
        );
        subject = LogIn(
          validateApiKey: validateApiKey,
          authenticateWithFirebase: authenticateWithFirebase,
        );
      });

      test('it returns true', () async {
        final isLoggedIn = await subject.call('apiKey');
        expect(isLoggedIn, isTrue);
      });
    });

    group('when api key is invalid', () {
      setUp(() {
        validateApiKey = FakeValidateApiKey(
          isValid: false,
          setApiKey: setApiKey,
        );
        authenticateWithFirebase = FakeAuthenticateWithFirebase(
          setFirebaseUid: setFirebaseUid,
        );
        subject = LogIn(
          validateApiKey: validateApiKey,
          authenticateWithFirebase: authenticateWithFirebase,
        );
      });

      test('it returns false', () async {
        final isLoggedIn = await subject.call('apiKey');
        expect(isLoggedIn, isFalse);
      });
    });

    group('when firebase authentication fails', () {
      setUp(() {
        validateApiKey = FakeValidateApiKey(
          setApiKey: setApiKey,
        );
        authenticateWithFirebase = FakeAuthenticateWithFirebase(
          isSuccessful: false,
          setFirebaseUid: setFirebaseUid,
        );
        subject = LogIn(
          validateApiKey: validateApiKey,
          authenticateWithFirebase: authenticateWithFirebase,
        );
      });

      test('it returns false', () async {
        final isLoggedIn = await subject.call('apiKey');
        expect(isLoggedIn, isFalse);
      });
    });
  });
}
