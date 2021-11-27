import 'package:flutter_test/flutter_test.dart';
import 'package:hydrawise/core/core.dart';
import 'package:hydrawise/features/auth/auth.dart';

void main() {
  group('SetApiKeyInStorage', () {
    final storage = InMemoryStorage();
    final setApiKey = SetApiKey(storage);

    test('it sets the API key at api_key', () async {
      await setApiKey('1234');
      expect(await storage.getString('api_key'), '1234');
    });
  });
}
