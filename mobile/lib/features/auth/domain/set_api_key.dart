import 'package:irri/core/core.dart';

class SetApiKey {
  SetApiKey(this._dataStorage);

  final DataStorage _dataStorage;

  Future<void> call(String apiKey) {
    return _dataStorage.setString('api_key', apiKey);
  }
}
