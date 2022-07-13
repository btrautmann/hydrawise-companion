import 'package:irri/auth/auth.dart';

class LogIn {
  LogIn({
    required ValidateApiKey validateApiKey,
  }) : _validateApiKey = validateApiKey;

  final ValidateApiKey _validateApiKey;

  Future<bool> call(String apiKey) async {
    return _validateApiKey(apiKey);
  }
}
