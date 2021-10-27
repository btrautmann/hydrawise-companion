import 'package:flutter_test/flutter_test.dart';
import 'package:hydrawise/core/core.dart';
import 'package:hydrawise/features/customer_details/api/domain/get_api_key.dart';

void main() {
  group('GetApiKeyFromStorage', () {
    final storage = InMemoryStorage();
    final getApiKey = GetApiKeyFromStorage(storage);

    test('it gets the API key from api_key', () async {
      await storage.setString('api_key', '1234');
      expect(await getApiKey(), '1234');
    });
  });
}
