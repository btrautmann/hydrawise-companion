import 'package:flutter/material.dart';
import 'package:hydrawise/core/core.dart';

/// Sets the new [ThemeMode] in provided
/// [DataStorage]. Uses the toString() of the [ThemeMode].
class SetAppThemeMode {
  final DataStorage _dataStorage;

  SetAppThemeMode(this._dataStorage);

  Future<void> call(ThemeMode mode) async {
    await _dataStorage.setString('app_theme_mode', mode.toString());
  }
}
