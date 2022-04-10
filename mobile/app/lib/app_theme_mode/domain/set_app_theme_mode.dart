import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Sets the new [ThemeMode] in provided
/// [DataStorage]. Uses the toString() of the [ThemeMode].
class SetAppThemeMode {
  SetAppThemeMode(this._dataStorage);

  final DataStorage _dataStorage;

  Future<void> call(ThemeMode mode) async {
    await _dataStorage.setString('app_theme_mode', mode.toString());
  }
}
