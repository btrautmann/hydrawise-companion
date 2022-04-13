import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrawise/hydrawise.dart';
import 'package:irri/auth/auth.dart';
import 'package:irri/customer_details/repository/repository.dart';

void main() {
  group('LogOut', () {
    late UnauthenticateWithFirebase unauthenticateWithFirebase;
    final storage = InMemoryStorage();
    final repository = InMemoryCustomerDetailsRepository();
    final setFirebaseUid = SetFirebaseUid(storage);
    final setApiKey = SetApiKey(storage);
    late LogOut subject;

    setUp(() async {
      await setApiKey('fake-api-key');
      await setFirebaseUid('fake-firebase-uid');
      await repository.insertCustomer(
        Customer(
          activeControllerId: 1,
          customerId: 1,
          apiKey: 'fake-api-key',
          lastStatusUpdate: DateTime.now().millisecondsSinceEpoch,
        ),
      );
    });

    test(
        'it clears all customer data, unauthenticates '
        'with firebase and clears api key', () async {
      unauthenticateWithFirebase = FakeUnauthenticateWithFirebase(
        setFirebaseUid: setFirebaseUid,
      );
      subject = LogOut(
        setApiKey: setApiKey,
        unauthenticateWithFirebase: unauthenticateWithFirebase,
        customerDetailsRepository: repository,
      );
      await subject.call();

      final apiKey = await GetApiKey(storage).call();
      expect(apiKey, isEmpty);

      final firebaseUid = await GetFirebaseUid(storage).call();
      expect(firebaseUid, isEmpty);

      final customer = await repository.getCustomer();
      expect(customer, isNull);
    });
  });
}
