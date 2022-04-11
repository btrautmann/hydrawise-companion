import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irri/auth/auth.dart';

void main() {
  group('GetFirebaseUid', () {
    final storage = InMemoryStorage();
    final subject = GetFirebaseUid(storage);

    test('it gets the firebase uid from firebase_uid', () async {
      await storage.setString('firebase_uid', 'fake-uid');
      expect(await subject.call(), 'fake-uid');
    });
  });
}
