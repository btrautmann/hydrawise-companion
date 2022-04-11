import 'package:clock/clock.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:irri/auth/auth.dart';

/// Authenticates with Firebase anonymously and returns
/// the user's uid if successful
class AuthenticateWithFirebase {
  AuthenticateWithFirebase({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required SetFirebaseUid setFirebaseUid,
  })  : _firestore = firestore,
        _auth = auth,
        _setFirebaseUid = setFirebaseUid;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final SetFirebaseUid _setFirebaseUid;

  Future<bool> call() async {
    final credential = await _auth.signInAnonymously();
    final uId = credential.user?.uid;
    if (uId != null) {
      await _firestore.collection('users').doc(uId).set(
        <String, dynamic>{
          'authentication_time': clock.now().toString(),
        },
        SetOptions(merge: true),
      );
      await _setFirebaseUid(uId);
      return true;
    }
    return false;
  }
}
