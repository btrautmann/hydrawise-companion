import 'package:api_models/api_models.dart';
import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:irri/auth/auth.dart';

/// {@template log_in}
/// Validates the provided API key and if valid,
/// stores it using [SetApiKey] and returns true.
///
/// If the API key is *not* valid, returns false.
/// {@endtemplate}
class LogIn {
  LogIn({
    required HttpClient httpClient,
    required SetApiKey setApiKey,
  })  : _httpClient = httpClient,
        _setApiKey = setApiKey;

  final HttpClient _httpClient;
  final SetApiKey _setApiKey;

  /// {@macro log_in}
  Future<bool> call(
    String apiKey,
    String timezone,
  ) async {
    final response = await _httpClient.post<Map<String, dynamic>>(
      'login',
      options: Options(
        extra: {'allow_auth_errors': true},
        headers: {'api_key': apiKey},
      ),
      data: LoginRequest(
        type: 'controllers',
      ).toJson(),
    );

    if (response.isSuccess) {
      await _setApiKey(apiKey);
    }

    return response.isSuccess;
  }
}
