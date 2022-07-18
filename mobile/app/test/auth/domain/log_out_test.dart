import 'package:api_models/api_models.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irri/auth/auth.dart';
import 'package:irri/customer_details/repository/repository.dart';

void main() {
  group('LogOut', () {
    final storage = InMemoryStorage();
    final repository = InMemoryCustomerDetailsRepository();
    final setApiKey = SetApiKey(storage);
    late LogOut subject;

    setUp(() async {
      await setApiKey('fake-api-key');
      await repository.insertCustomer(
        Customer(
          activeControllerId: 1,
          customerId: 1,
        ),
      );
    });

    test('it clears all customer data and clears api key', () async {
      subject = LogOut(
        setApiKey: setApiKey,
        customerDetailsRepository: repository,
      );
      await subject.call();

      final apiKey = await GetApiKey(storage).call();
      expect(apiKey, isEmpty);

      final customer = await repository.getCustomer();
      expect(customer, isNull);
    });
  });
}
