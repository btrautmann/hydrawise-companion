import 'package:flutter_test/flutter_test.dart';
import 'package:irri/core/core.dart';
import 'package:irri/features/auth/auth.dart';

void main() {
  group('IsLoggedIn', () {
    final storage = InMemoryStorage();
    final setApiKey = SetApiKey(storage);
    final setFirebaseUid = SetFirebaseUid(storage);
    final subject = IsLoggedIn(
      getApiKey: GetApiKey(storage),
      getFirebaseUid: GetFirebaseUid(storage),
    );

    setUp(storage.clearAll);

    group('when api key and firebase uid are stored', () {
      setUp(() async {
        await setApiKey('fake-api-key');
        await setFirebaseUid('fake-firebase-uid');
      });
      test('is returns true', () async {
        final isLoggedIn = await subject.call();
        expect(isLoggedIn, isTrue);
      });
    });

    group('when only api key is stored', () {
      setUp(() async {
        await setApiKey('fake-api-key');
      });
      test('is returns false', () async {
        final isLoggedIn = await subject.call();
        expect(isLoggedIn, isFalse);
      });
    });

    group('when only firebase uid is stored', () {
      setUp(() async {
        await setFirebaseUid('fake-firebase-uid');
      });
      test('is returns false', () async {
        final isLoggedIn = await subject.call();
        expect(isLoggedIn, isFalse);
      });
    });

    group('when neither api key or firebase uid are stored', () {
      test('is returns false', () async {
        final isLoggedIn = await subject.call();
        expect(isLoggedIn, isFalse);
      });
    });
  });
}
