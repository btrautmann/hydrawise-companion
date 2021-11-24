import 'package:hydrawise/core/core.dart';

class SetFirebaseUid {
  SetFirebaseUid(this._dataStorage);

  final DataStorage _dataStorage;

  Future<void> call(String uId) {
    return _dataStorage.setString('firebase_uid', uId);
  }
}
