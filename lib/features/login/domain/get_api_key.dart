
import 'package:hydrawise/core/core.dart';

typedef GetApiKey = Future<String?> Function();

class GetApiKeyFromStorage {
  GetApiKeyFromStorage(this._dataStorage);

  final DataStorage _dataStorage;

  Future<String?> call() {
    return _dataStorage.getString('api_key');
  }
}
