import 'package:flutter_test/flutter_test.dart';
import 'package:hydrawise/core/core.dart';
import 'package:hydrawise/features/customer_details/customer_details.dart';

void main() {
  group('ClearCustomerDetailsFromStorage', () {
    final storage = InMemoryStorage();
    final clearCustomerDetailsFromStorage = ClearCustomerDetailsFromStorage(
      dataStorage: storage,
      customerDetailsRepository: InMemoryCustomerDetailsRepository(),
    );
    test('it sets api_key to an empty string', () async {
      await storage.setString('api_key', '1234');
      expect(await storage.getString('api_key'), '1234');
      await clearCustomerDetailsFromStorage();
      expect(await storage.getString('api_key'), '');
    });
  });
}
