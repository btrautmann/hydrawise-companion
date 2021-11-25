import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Authenticates with Firebase anonymously and returns
/// the user's uid if successful
class AuthenticateWithFirebase {
  AuthenticateWithFirebase({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  })  : _firestore = firestore,
        _auth = auth;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  Future<String?> call() async {
    final credential = await _auth.signInAnonymously();
    final uId = credential.user?.uid;
    if (uId != null) {
      await _firestore.collection('users').doc(uId).set(
        <String, dynamic>{
          'authentication_time': DateTime.now().toString(),
        },
      );
    }
    return credential.user?.uid;
  }
}

class FakeAuthenticateWithFirebase implements AuthenticateWithFirebase {
  @override
  FirebaseAuth get _auth => throw UnimplementedError();

  @override
  FirebaseFirestore get _firestore => throw UnimplementedError();

  @override
  Future<String?> call() async {
    return 'fake-user-uid';
  }
}
