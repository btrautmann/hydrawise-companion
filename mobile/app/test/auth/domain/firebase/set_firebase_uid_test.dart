import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irri/auth/auth.dart';

void main() {
  group('SetFirebaseUid', () {
    final storage = InMemoryStorage();
    final subject = SetFirebaseUid(storage);

    test('it sets the firebase uid at firebase_uid', () async {
      await subject.call('fake-uid');
      expect(await storage.getString('firebase_uid'), 'fake-uid');
    });
  });
}
