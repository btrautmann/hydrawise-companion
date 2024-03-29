import 'package:core/core.dart';
import 'package:flutter/material.dart';

class GetAppThemeMode {
  GetAppThemeMode(this._dataStorage);

  final DataStorage _dataStorage;

  Future<ThemeMode> call() async {
    final themeModeString = await _dataStorage.getString('app_theme_mode');
    final mode = themeModeString == null
        ? ThemeMode.system
        : themeModeString.toThemeMode();
    return mode;
  }
}

extension on String {
  /// Converts the [ThemeMode] String stored in [DataStorage]
  /// to an actual [ThemeMode] object. In the case of an
  /// unrecognized mode, defaults to [ThemeMode.system].
  ThemeMode toThemeMode() {
    if (this == 'ThemeMode.dark') {
      return ThemeMode.dark;
    } else if (this == 'ThemeMode.light') {
      return ThemeMode.light;
    } else {
      return ThemeMode.system;
    }
  }
}
