import 'package:irri/auth/domain/get_api_key.dart';

/// {@template is_logged_in}
/// Checks the stored API key
/// to determine if the user is fully authenticated. Returns
/// true if they are, and false otherwise.
/// {@endtemplate}
class IsLoggedIn {
  IsLoggedIn({
    required GetApiKey getApiKey,
  }) : _getApiKey = getApiKey;

  final GetApiKey _getApiKey;

  /// {@macro is_logged_in}
  Future<bool> call() async {
    final apiKey = await _getApiKey();
    return apiKey.isNotNullOrEmpty();
  }
}

extension on String? {
  bool isNotNullOrEmpty() {
    return this != null && this!.isNotEmpty;
  }
}
