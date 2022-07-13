import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irri/auth/auth.dart';

void main() {
  group('LogIn', () {
    late ValidateApiKey validateApiKey;
    final storage = InMemoryStorage();
    final setApiKey = SetApiKey(storage);
    late LogIn subject;

    setUp(storage.clearAll);

    group('when api key is valid', () {
      setUp(() {
        validateApiKey = FakeValidateApiKey(setApiKey: setApiKey);
        subject = LogIn(
          validateApiKey: validateApiKey,
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
        subject = LogIn(
          validateApiKey: validateApiKey,
        );
      });

      test('it returns false', () async {
        final isLoggedIn = await subject.call('apiKey');
        expect(isLoggedIn, isFalse);
      });
    });
  });
}
