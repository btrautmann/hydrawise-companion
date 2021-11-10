import 'package:hydrawise/core/core.dart';

abstract class GetApiKey {
  Future<String?> call();
}

class GetApiKeyFromStorage implements GetApiKey {
  GetApiKeyFromStorage(this._dataStorage);

  final DataStorage _dataStorage;

  @override
  Future<String?> call() {
    return _dataStorage.getString('api_key');
  }
}
