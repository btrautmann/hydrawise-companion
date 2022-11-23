import 'package:api_models/api_models.dart';
import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:irri/auth/providers.dart';
import 'package:irri/auth/set_api_key.dart';

part 'log_in_controller.dart';

class LogIn {
  LogIn({
    required HttpClient httpClient,
    required SetApiKey setApiKey,
  })  : _httpClient = httpClient,
        _setApiKey = setApiKey;

  final HttpClient _httpClient;
  final SetApiKey _setApiKey;

  Future<bool> call({
    required String apiKey,
  }) async {
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
