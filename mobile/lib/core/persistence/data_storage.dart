import 'package:shared_preferences/shared_preferences.dart';

abstract class DataStorage {
  Future<String?> getString(String key);
  Future<void> setString(String key, String value);
  Future<void> setInt(String key, int value);
  Future<int?> getInt(String key);
  Future<Map<String, dynamic>> getAll();
  Future<bool> clearAll();
}

class SharedPreferencesStorage implements DataStorage {
  SharedPreferencesStorage(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  @override
  Future<void> setString(String key, String value) {
    return _sharedPreferences.setString(key, value);
  }

  @override
  Future<String?> getString(String key) async {
    return _sharedPreferences.getString(key);
  }

  @override
  Future<void> setInt(String key, int value) {
    return _sharedPreferences.setInt(key, value);
  }

  @override
  Future<int?> getInt(String key) async {
    return _sharedPreferences.getInt(key);
  }

  @override
  Future<Map<String, dynamic>> getAll() async {
    final keys = _sharedPreferences.getKeys();
    final map = <String, dynamic>{};
    for (final k in keys) {
      map[k] = _sharedPreferences.get(k);
    }
    return map;
  }

  @override
  Future<bool> clearAll() async {
    return _sharedPreferences.clear();
  }
}

class InMemoryStorage implements DataStorage {
  final Map<String, dynamic> storage = <String, dynamic>{};

  @override
  Future<void> setString(String key, String value) async {
    storage[key] = value;
  }

  @override
  Future<String?> getString(String key) async {
    return storage[key] as String?;
  }

  @override
  Future<void> setInt(String key, int value) async {
    storage[key] = value;
  }

  @override
  Future<int?> getInt(String key) async {
    return storage[key] as int?;
  }

  @override
  Future<Map<String, dynamic>> getAll() async {
    return storage;
  }

  @override
  Future<bool> clearAll() async {
    storage.clear();
    return true;
  }
}
