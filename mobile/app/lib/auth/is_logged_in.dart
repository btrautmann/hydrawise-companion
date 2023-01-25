import 'package:irri/auth/get_api_key.dart';

class IsLoggedIn {
  IsLoggedIn({
    required GetApiKey getApiKey,
  }) : _getApiKey = getApiKey;

  final GetApiKey _getApiKey;

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
