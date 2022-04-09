import 'package:irri/core/core.dart';

/// {@template get_api_key}
/// Retrieves the API key from `api_key` slot in the
/// provided [DataStorage]
/// {@endtemplate}
class GetApiKey {
  GetApiKey(this._dataStorage);

  final DataStorage _dataStorage;

  /// {@macro get_api_key}
  Future<String?> call() {
    return _dataStorage.getString('api_key');
  }
}
