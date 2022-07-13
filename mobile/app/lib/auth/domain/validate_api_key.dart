import 'package:api_models/api_models.dart';
import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:irri/auth/auth.dart';

/// {@template validate_api_key}
/// Validates the provided API key and if valid,
/// stores it using [SetApiKey] and returns true.
///
/// If the API key is *not* valid, returns false.
/// {@endtemplate}
class ValidateApiKey {
  ValidateApiKey({
    required HttpClient httpClient,
    required SetApiKey setApiKey,
  })  : _httpClient = httpClient,
        _setApiKey = setApiKey;

  final HttpClient _httpClient;
  final SetApiKey _setApiKey;

  /// {@macro validate_api_key}
  Future<bool> call(String apiKey) async {
    final response = await _httpClient.post<Map<String, dynamic>>(
      'login',
      options: Options(
        extra: {'allow_auth_errors': true},
      ),
      data: LoginRequest(apiKey: apiKey, type: 'controllers').toJson(),
    );

    if (response.isSuccess) {
      await _setApiKey(apiKey);
    }

    return response.isSuccess;
  }
}
