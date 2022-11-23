import 'package:core/core.dart';

class GetApiKey {
  GetApiKey(this._dataStorage);

  final DataStorage _dataStorage;

  Future<String?> call() {
    return _dataStorage.getString('api_key');
  }
}
