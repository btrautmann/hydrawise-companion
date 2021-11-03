import 'package:flutter/material.dart';
import 'package:hydrawise/core/core.dart';

/// Contract for obtaining the current app [ThemeMode]
abstract class GetAppThemeMode {
  Future<ThemeMode> call();
}

/// Obtains the current app [ThemeMode] from the provided
/// [DataStorage]. If no mode has been set previously,
/// defaults to [ThemeMode.system].
class GetAppThemeModeFromStorage implements GetAppThemeMode {
  final DataStorage _dataStorage;

  GetAppThemeModeFromStorage(this._dataStorage);

  @override
  Future<ThemeMode> call() async {
    final themeModeString = await _dataStorage.getString('app_theme_mode');
    final mode = themeModeString == null ? ThemeMode.system : themeModeString.toThemeMode();
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
