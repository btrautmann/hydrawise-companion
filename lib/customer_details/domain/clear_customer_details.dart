
import 'package:hydrawise/core/core.dart';

typedef ClearCustomerDetails = Future<void> Function();

class ClearCustomerDetailsFromStorage {
  ClearCustomerDetailsFromStorage(this._dataStorage);

  final DataStorage _dataStorage;

  Future<void> call() async {
    return _dataStorage.setString('api_key', '');
  }
}
