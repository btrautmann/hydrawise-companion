import 'package:irri/core/core.dart';

/// {@template set_api_key}
/// Sets the provided API key at the `api_key` slot
/// in the provided [DataStorage]
/// {@endtemplate}
class SetApiKey {
  SetApiKey(this._dataStorage);

  final DataStorage _dataStorage;

  /// {@macro set_api_key}
  Future<void> call(String apiKey) {
    return _dataStorage.setString('api_key', apiKey);
  }
}
