import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irri/app_theme_mode/app_theme_mode.dart';

void main() {
  group('GetAppThemeModeFromStorage', () {
    final storage = InMemoryStorage();
    final getAppThemeMode = GetAppThemeMode(storage);

    test('it gets the app ThemeMode from app_theme_mode', () async {
      await storage.setString('app_theme_mode', 'ThemeMode.dark');
      expect(await getAppThemeMode(), ThemeMode.dark);
    });
  });
}
