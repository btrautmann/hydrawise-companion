import 'package:flutter_test/flutter_test.dart';
import 'package:hydrawise/hydrawise.dart';
import 'package:irri/configuration/configuration.dart';
import 'package:irri/customer_details/repository/repository.dart';

void main() {
  group('UpdateUserTimeZone', () {
    final repository = InMemoryCustomerDetailsRepository();
    final subject = UpdateUserTimeZone(repository: repository);

    tearDown(repository.clearAllData);
    test('it updates the time zone in the repository', () async {
      await repository.insertCustomer(
        Customer(
          activeControllerId: 1,
          customerId: 1,
          apiKey: 'fake-api-key',
          lastStatusUpdate: DateTime.now().millisecondsSinceEpoch,
          timeZone: 'America/New York',
        ),
      );

      await subject.call('Fake time zone');

      final timeZone = await repository.getUserTimeZone();
      expect(timeZone, 'Fake time zone');
    });
  });
}
