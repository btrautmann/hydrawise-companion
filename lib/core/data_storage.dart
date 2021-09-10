import 'package:shared_preferences/shared_preferences.dart';

abstract class DataStorage {
  Future<String?> getString(String key);
  Future<void> setString(String key, String value);
  Future<bool> clearAll();
}

class SharedPreferencesStorage implements DataStorage {
  SharedPreferencesStorage(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  @override
  Future<String?> getString(String key) async {
    return _sharedPreferences.getString(key);
  }

  @override
  Future<void> setString(String key, String value) {
    return _sharedPreferences.setString(key, value);
  }

  @override
  Future<bool> clearAll() async {
    return _sharedPreferences.clear();
  }
}

class InMemoryStorage implements DataStorage {
  final Map<String, dynamic> storage = <String, dynamic>{};

  @override
  Future<String?> getString(String key) async {
    return storage[key] as String?;
  }

  @override
  Future<void> setString(String key, String value) async {
    storage[key] = value;
  }

  @override
  Future<bool> clearAll() async {
    storage.clear();
    return true;
  }
}
