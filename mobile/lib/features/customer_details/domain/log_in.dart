import 'package:hydrawise/features/auth/auth.dart';
import 'package:hydrawise/features/auth/domain/validate_api_key.dart';

class LogIn {
  LogIn({
    required ValidateApiKey validateApiKey,
    required AuthenticateWithFirebase authenticateWithFirebase,
  })  : _validateApiKey = validateApiKey,
        _authenticateWithFirebase = authenticateWithFirebase;

  final ValidateApiKey _validateApiKey;
  final AuthenticateWithFirebase _authenticateWithFirebase;

  Future<bool> call(String apiKey) async {
    final isValidApiKey = await _validateApiKey(apiKey);
    if (isValidApiKey) {
      return _authenticateWithFirebase();
    }
    return false;
  }
}