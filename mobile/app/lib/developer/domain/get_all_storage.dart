import 'package:core/core.dart';

class GetAllStorage {
  GetAllStorage(this._dataStorage);

  final DataStorage _dataStorage;

  Future<Map<String, dynamic>> call() {
    return _dataStorage.getAll();
  }
}
