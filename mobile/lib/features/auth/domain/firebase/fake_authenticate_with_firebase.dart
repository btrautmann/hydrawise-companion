import 'package:irri/features/auth/domain/firebase/authenticate_with_firebase.dart';
import 'package:irri/features/auth/domain/firebase/set_firebase_uid.dart';

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
