import 'package:irri/auth/auth.dart';

/// {@template fake_authenticate_with_firebase}
/// An implementation of [AuthenticateWithFirebase] whose return value
/// is dependent on its input. If true, sets a fake Firebase uId.
/// {@endtemplate}
class FakeAuthenticateWithFirebase implements AuthenticateWithFirebase {
  FakeAuthenticateWithFirebase({
    bool isSuccessful = true,
    required SetFirebaseUid setFirebaseUid,
  })  : _isSuccessful = isSuccessful,
        _setFirebaseUid = setFirebaseUid;

  final bool _isSuccessful;
  final SetFirebaseUid _setFirebaseUid;

  /// {@macro fake_authenticate_with_firebase}
  @override
  Future<bool> call() async {
    if (_isSuccessful) {
      await _setFirebaseUid('fake-user-uid');
    }
    return _isSuccessful;
  }
}
