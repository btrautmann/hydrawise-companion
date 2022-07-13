import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irri/auth/auth.dart';

void main() {
  group('IsLoggedIn', () {
    final storage = InMemoryStorage();
    final setApiKey = SetApiKey(storage);
    final subject = IsLoggedIn(
      getApiKey: GetApiKey(storage),
    );

    setUp(storage.clearAll);

    group('when api key is stored', () {
      setUp(() async {
        await setApiKey('fake-api-key');
      });
      test('is returns true', () async {
        final isLoggedIn = await subject.call();
        expect(isLoggedIn, isTrue);
      });
    });

    group('when api key is not stored', () {
      test('is returns false', () async {
        final isLoggedIn = await subject.call();
        expect(isLoggedIn, isFalse);
      });
    });
  });
}
