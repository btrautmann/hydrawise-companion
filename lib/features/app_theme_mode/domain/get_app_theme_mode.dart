import 'package:flutter/material.dart';
import 'package:hydrawise/core/core.dart';

typedef GetAppThemeMode = Future<ThemeMode> Function();

class GetAppThemeModeFromStorage {
  final DataStorage _dataStorage;

  GetAppThemeModeFromStorage(this._dataStorage);

  Future<ThemeMode> call() async {
    final themeModeString = await _dataStorage.getString('app_theme_mode');
    final mode = themeModeString == null ? ThemeMode.system : themeModeString.toThemeMode();
    return mode;
  }
}

extension on String {
  ThemeMode toThemeMode() {
    print('Parsing this: $this');
    if (this == 'ThemeMode.dark') {
      return ThemeMode.dark;
    } else if (this == 'ThemeMode.light') {
      return ThemeMode.light;
    } else {
      return ThemeMode.system;
    }
  }
}
