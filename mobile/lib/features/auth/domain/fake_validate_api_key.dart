import 'package:irri/features/auth/domain/domain.dart';

class FakeValidateApiKey implements ValidateApiKey {
  FakeValidateApiKey({
    required SetApiKey setApiKey,
  }) : _setApiKey = setApiKey;

  final SetApiKey _setApiKey;

  @override
  Future<bool> call(String apiKey) async {
    await _setApiKey(apiKey);
    return true;
  }
}
