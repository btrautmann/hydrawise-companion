import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irri/auth/auth.dart';

void main() {
  group('GetApiKey', () {
    final storage = InMemoryStorage();
    final getApiKey = GetApiKey(storage);

    test('it gets the API key from api_key', () async {
      await storage.setString('api_key', '1234');
      expect(await getApiKey(), '1234');
    });
  });
}
