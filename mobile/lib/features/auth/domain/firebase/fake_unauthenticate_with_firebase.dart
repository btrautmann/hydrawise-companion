import 'package:irri/features/auth/domain/firebase/set_firebase_uid.dart';
import 'package:irri/features/auth/domain/firebase/unauthenticate_with_firebase.dart';

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
