import 'package:irri/auth/auth.dart';

/// {@template fake_validate_api_key}
/// An implementation of [ValidateApiKey] whose return value
/// is dependent on its input. If true, sets the provided
/// API key using [SetApiKey].
/// {@endtemplate}
class FakeValidateApiKey implements ValidateApiKey {
  FakeValidateApiKey({
    bool isValid = true,
    required SetApiKey setApiKey,
  })  : _isValid = isValid,
        _setApiKey = setApiKey;

  final bool _isValid;
  final SetApiKey _setApiKey;

  /// {@macro fake_validate_api_key}
  @override
  Future<bool> call(String apiKey) async {
    if (_isValid) {
      await _setApiKey(apiKey);
    }
    return _isValid;
  }
}
