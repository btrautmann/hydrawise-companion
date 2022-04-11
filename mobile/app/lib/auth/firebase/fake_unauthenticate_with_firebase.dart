import 'package:irri/auth/auth.dart';

class FakeUnauthenticateWithFirebase implements UnauthenticateWithFirebase {
  FakeUnauthenticateWithFirebase({
    required SetFirebaseUid setFirebaseUid,
  }) : _setFirebaseUid = setFirebaseUid;

  final SetFirebaseUid _setFirebaseUid;
  @override
  Future<void> call() async {
    await _setFirebaseUid('');
  }
}
