import 'package:flutter/material.dart';
import 'package:hydrawise/core/core.dart';

/// Contract for setting the new app [ThemeMode]
abstract class SetAppThemeMode {
  Future<void> call(ThemeMode mode);
}

/// Sets the new [ThemeMode] in provided
/// [DataStorage]. Uses the toString() of the [ThemeMode].
class SetAppThemeModeInStorage implements SetAppThemeMode {
  final DataStorage _dataStorage;

  SetAppThemeModeInStorage(this._dataStorage);

  @override
  Future<void> call(ThemeMode mode) async {
    await _dataStorage.setString('app_theme_mode', mode.toString());
  }
}
