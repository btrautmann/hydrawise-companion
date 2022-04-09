import 'package:dio/dio.dart';
import 'package:irri/core/core.dart';
import 'package:irri/features/auth/auth.dart';

class ValidateApiKey {
  ValidateApiKey({
    required HttpClient httpClient,
    required SetApiKey setApiKey,
  })  : _httpClient = httpClient,
        _setApiKey = setApiKey;

  final HttpClient _httpClient;
  final SetApiKey _setApiKey;

  Future<bool> call(String apiKey) async {
    final queryParameters = {
      'api_key': apiKey,
      'type': 'controllers',
    };

    final response = await _httpClient.get<Map<String, dynamic>>(
      'customerdetails.php',
      queryParameters: queryParameters,
      options: Options(
        extra: {'allow_auth_errors': true},
      ),
    );

    if (response.isSuccess) {
      await _setApiKey(apiKey);
    }

    return response.isSuccess;
  }
}
