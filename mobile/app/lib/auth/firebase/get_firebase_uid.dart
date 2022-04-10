import 'package:core/core.dart';

class GetFirebaseUid {
  GetFirebaseUid(this._dataStorage);

  final DataStorage _dataStorage;

  Future<String?> call() {
    return _dataStorage.getString('firebase_uid');
  }
}
