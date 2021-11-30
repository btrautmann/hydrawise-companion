import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irri/core/core.dart';
import 'package:irri/features/app_theme_mode/app_theme_mode.dart';

void main() {
  group('SetAppThemeModeInStorage', () {
    final storage = InMemoryStorage();
    final setAppThemeMode = SetAppThemeMode(storage);

    test('it sets the app ThemeMode at app_theme_mode', () async {
      await setAppThemeMode(ThemeMode.dark);
      expect(await storage.getString('app_theme_mode'), 'ThemeMode.dark');
    });
  });
}
