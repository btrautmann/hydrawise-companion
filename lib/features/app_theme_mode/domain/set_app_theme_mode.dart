import 'package:flutter/material.dart';
import 'package:hydrawise/core/core.dart';

typedef SetAppThemeMode = Future<void> Function(ThemeMode mode);

class SetAppThemeModeInStorage {
  final DataStorage _dataStorage;

  SetAppThemeModeInStorage(this._dataStorage);

  Future<void> call(ThemeMode mode) async {
    await _dataStorage.setString('app_theme_mode', mode.toString());
  }
}
