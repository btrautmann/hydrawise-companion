import 'package:hydrawise/core/core.dart';

typedef GetLocation = Future<String?> Function();

class GetLocationFromStorage {
  GetLocationFromStorage(this._dataStorage);

  final DataStorage _dataStorage;

  Future<String?> call() {
    return _dataStorage.getString('location_city');
  }
}
