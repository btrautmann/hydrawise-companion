import 'package:flutter_test/flutter_test.dart';
import 'package:hydrawise/core/core.dart';
import 'package:hydrawise/features/auth/auth.dart';
import 'package:hydrawise/features/customer_details/customer_details.dart';

void main() {
  group('ClearCustomerDetails', () {
    final storage = InMemoryStorage();
    final repository = InMemoryCustomerDetailsRepository();
    final setApiKey = SetApiKey(storage);
    final setFirebaseUid = SetFirebaseUid(storage);
    final clearCustomerDetails = ClearCustomerDetails(
      setApiKey: setApiKey,
      setFirebaseUid: setFirebaseUid,
      customerDetailsRepository: repository,
    );
    test('it sets api_key to an empty string', () async {
      await storage.setString('api_key', '1234');
      expect(await storage.getString('api_key'), '1234');
      await clearCustomerDetails();
      expect(await storage.getString('api_key'), '');
    });

    test('it clears all data in the repository', () async {
      final zone = Zone(
        id: 1,
        physicalNumber: 1,
        name: 'Fake Zone',
        nextTimeOfWaterFriendly: '7:00',
        secondsUntilNextRun: 60,
        lengthOfNextRunTimeOrTimeRemaining: 500,
      );
      await repository.insertZone(zone);
      final customer = CustomerIdentification(
        activeControllerId: 1,
        customerId: 1,
        apiKey: 'fake-api-key',
        lastStatusUpdate: 60,
      );
      await repository.insertCustomer(customer);

      expect(await repository.getZones(), isNotEmpty);
      expect(await repository.getCustomers(), isNotEmpty);
      await clearCustomerDetails();
      expect(await repository.getZones(), isEmpty);
      expect(await repository.getCustomers(), isEmpty);
    });
  });
}
