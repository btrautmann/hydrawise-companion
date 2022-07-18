import 'package:api_models/api_models.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irri/auth/auth.dart';
import 'package:irri/customer_details/customer_details.dart';

void main() {
  group('ClearCustomerDetails', () {
    final storage = InMemoryStorage();
    final repository = InMemoryCustomerDetailsRepository();
    final setApiKey = SetApiKey(storage);
    final logOut = LogOut(
      setApiKey: setApiKey,
      customerDetailsRepository: repository,
    );
    test('it sets api_key to an empty string', () async {
      await storage.setString('api_key', '1234');
      expect(await storage.getString('api_key'), '1234');
      await logOut();
      expect(await storage.getString('api_key'), '');
    });

    test('it clears all data in the repository', () async {
      final zone = Zone(
        id: 1,
        number: 1,
        name: 'Fake Zone',
        timeUntilNextRunSec: 60,
        runLengthSec: 500,
      );
      await repository.insertZone(zone);
      final customer = Customer(
        activeControllerId: 1,
        customerId: 1,
      );
      await repository.insertCustomer(customer);
      await repository.insertProgram(
        Program(
          id: 12345,
          name: 'Fake Program',
          frequency: [DateTime.monday],
          runs: List.empty(),
        ),
      );
      await repository.addFcmToken('fake-token');

      expect(await repository.getZones(), isNotEmpty);
      expect(await repository.getPrograms(), isNotEmpty);
      expect(await repository.getRegisteredFcmTokens(), isNotEmpty);
      await logOut();
      expect(await repository.getZones(), isEmpty);
      expect(await repository.getPrograms(), isEmpty);
      expect(await repository.getRegisteredFcmTokens(), isEmpty);
    });
  });
}
