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
    );

    if (response.isSuccess) {
      await _setApiKey(apiKey);
    }

    return response.isSuccess;
  }
}

class FakeValidateApiKey implements ValidateApiKey {
  FakeValidateApiKey({
    required SetApiKey setApiKey,
  }) : _setApiKey = setApiKey;

  @override
  final SetApiKey _setApiKey;

  @override
  HttpClient get _httpClient => throw UnimplementedError();

  @override
  Future<bool> call(String apiKey) async {
    await _setApiKey(apiKey);
    return true;
  }
}
