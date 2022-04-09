import 'package:irri/features/auth/auth.dart';

/// {@template is_logged_in}
/// Checks both the stored API key and stored Firebase uId
/// to determine if the user is fully authenticated. Returns
/// true if they are, and false otherwise.
/// {@endtemplate}
class IsLoggedIn {
  IsLoggedIn({
    required GetApiKey getApiKey,
    required GetFirebaseUid getFirebaseUid,
  })  : _getApiKey = getApiKey,
        _getFirebaseUid = getFirebaseUid;

  final GetApiKey _getApiKey;
  final GetFirebaseUid _getFirebaseUid;

  /// {@macro is_logged_in}
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
