import 'package:hydrawise/core/core.dart';

class GetFirebaseUid {
  final DataStorage _dataStorage;

  GetFirebaseUid(this._dataStorage);

  Future<String?> call() {
    return _dataStorage.getString('firebase_uid');
  }
}
