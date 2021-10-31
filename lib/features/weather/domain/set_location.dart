import 'package:hydrawise/core/core.dart';

typedef SetLocation = Future<void> Function(String cityName);

class SetLocationInStorage {
  SetLocationInStorage(this._dataStorage);

  final DataStorage _dataStorage;

  Future<void> call(String cityName) {
    return _dataStorage.setString('location_city', cityName);
  }
}
