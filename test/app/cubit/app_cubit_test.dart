import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrawise/app/cubit/app_cubit.dart';
import 'package:hydrawise/core/core.dart';
import 'package:hydrawise/features/app_theme_mode/domain/get_app_theme_mode.dart';
import 'package:hydrawise/features/app_theme_mode/domain/set_app_theme_mode.dart';

void main() {
  group('AppCubit', () {
    final dataStorage = InMemoryStorage();
    final setAppTheme = SetAppThemeModeInStorage(dataStorage);
    final getAppTheme = GetAppThemeModeFromStorage(dataStorage);
    AppCubit _buildSubject() {
      return AppCubit(
        setAppThemeMode: setAppTheme,
        getAppThemeMode: getAppTheme,
      );
    }

    setUp(() async {
      await dataStorage.clearAll();
    });

    group('init', () {
      group('when no app theme has been set', () {
        blocTest(
          'it emits [ThemeMode.system]',
          build: () => _buildSubject(),
          expect: () => <AppState>[
            AppState(themeMode: ThemeMode.system),
          ],
        );
      });

      group('when app theme has been set to dark', () {
        blocTest(
          'it emits [ThemeMode.dark]',
          setUp: () async => await setAppTheme(ThemeMode.dark),
          build: () => _buildSubject(),
          expect: () => <AppState>[
            AppState(themeMode: ThemeMode.dark),
          ],
        );
      });

      group('when app theme has been set to light', () {
        blocTest(
          'it emits [ThemeMode.light]',
          setUp: () async => await setAppTheme(ThemeMode.light),
          build: () => _buildSubject(),
          expect: () => <AppState>[
            AppState(themeMode: ThemeMode.light),
          ],
        );
      });

      group('when app theme has been set to system', () {
        blocTest(
          'it emits [ThemeMode.dark]',
          setUp: () async => await setAppTheme(ThemeMode.system),
          build: () => _buildSubject(),
          expect: () => <AppState>[
            AppState(themeMode: ThemeMode.system),
          ],
        );
      });
    });

    group('setThemeMode', () {
      blocTest<AppCubit, AppState>(
        'it emits the new ThemeMode',
        build: () => _buildSubject(),
        act: (cubit) => cubit.setThemeMode(ThemeMode.dark),
        skip: 1,
        expect: () => <AppState>[AppState(themeMode: ThemeMode.dark)],
      );
    });
  });
}
