import 'package:irri/features/auth/auth.dart';

class IsLoggedIn {
  IsLoggedIn({
    required GetApiKey getApiKey,
    required GetFirebaseUid getFirebaseUid,
  })  : _getApiKey = getApiKey,
        _getFirebaseUid = getFirebaseUid;

  final GetApiKey _getApiKey;
  final GetFirebaseUid _getFirebaseUid;

  Future<bool> call() async {
    final apiKey = await _getApiKey();
    final firebaseUid = await _getFirebaseUid();
    if (apiKey.isNotNullOrEmpty() && firebaseUid.isNotNullOrEmpty()) {
      return true;
    }
    return false;
  }
}

extension on String? {
  bool isNotNullOrEmpty() {
    return this != null && this!.isNotEmpty;
  }
}
