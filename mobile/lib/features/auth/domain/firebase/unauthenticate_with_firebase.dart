import 'package:firebase_auth/firebase_auth.dart';
import 'package:irri/features/auth/auth.dart';

class UnauthenticateWithFirebase {
  UnauthenticateWithFirebase({
    required FirebaseAuth firebaseAuth,
    required SetFirebaseUid setFirebaseUid,
  })  : _auth = firebaseAuth,
        _setFirebaseUid = setFirebaseUid;

  final FirebaseAuth _auth;
  final SetFirebaseUid _setFirebaseUid;

  Future<void> call() async {
    await _setFirebaseUid('');
    return _auth.signOut();
  }
}
