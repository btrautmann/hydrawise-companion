import 'package:hydrawise/core/core.dart';

class SetLocation {
  SetLocation(this._dataStorage);

  final DataStorage _dataStorage;

  Future<void> call(String cityName) {
    return _dataStorage.setString('location_city', cityName);
  }
}
