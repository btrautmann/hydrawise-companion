import 'package:irri/features/auth/auth.dart';

/// {@template fake_validate_api_key}
/// An implementation of [ValidateApiKey] that always
/// returns true after setting the provided API key
/// using [SetApiKey].
/// {@endtemplate}
class FakeValidateApiKey implements ValidateApiKey {
  FakeValidateApiKey({
    required SetApiKey setApiKey,
  }) : _setApiKey = setApiKey;

  final SetApiKey _setApiKey;

  /// {@macro fake_validate_api_key}
  @override
  Future<bool> call(String apiKey) async {
    await _setApiKey(apiKey);
    return true;
  }
}
