import 'package:hydrawise/core/core.dart';

class SetFirebaseUid {
  final DataStorage _dataStorage;

  SetFirebaseUid(this._dataStorage);

  Future<void> call(String uId) {
    return _dataStorage.setString('firebase_uid', uId);
  }
}
