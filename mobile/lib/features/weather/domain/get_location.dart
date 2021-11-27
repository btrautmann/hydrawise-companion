import 'package:hydrawise/core/core.dart';

class GetLocation {
  GetLocation(this._dataStorage);

  final DataStorage _dataStorage;

  Future<String?> call() {
    return _dataStorage.getString('location_city');
  }
}
