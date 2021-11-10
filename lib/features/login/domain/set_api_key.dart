import 'package:hydrawise/core/core.dart';

abstract class SetApiKey {
  Future<void> call(String apiKey);
}

class SetApiKeyInStorage implements SetApiKey {
  SetApiKeyInStorage(this._dataStorage);

  final DataStorage _dataStorage;

  @override
  Future<void> call(String apiKey) {
    return _dataStorage.setString('api_key', apiKey);
  }
}
