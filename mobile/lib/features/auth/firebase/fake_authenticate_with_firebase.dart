
import 'package:irri/features/auth/auth.dart';

class FakeAuthenticateWithFirebase implements AuthenticateWithFirebase {
  FakeAuthenticateWithFirebase({
    required SetFirebaseUid setFirebaseUid,
  }) : _setFirebaseUid = setFirebaseUid;

  final SetFirebaseUid _setFirebaseUid;

  @override
  Future<bool> call() async {
    await _setFirebaseUid('fake-user-uid');
    return true;
  }
}
