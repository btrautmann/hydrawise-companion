import 'package:hydrawise/core/data_storage.dart';

typedef SetApiKey = Future<void> Function(String apiKey);

class SetApiKeyInStorage {
  SetApiKeyInStorage(this._dataStorage);

  final DataStorage _dataStorage;

  Future<void> call(String apiKey) {
    return _dataStorage.setString('api_key', apiKey);
  }
}
