import 'dart:async';

import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:irri/app_theme_mode/get_app_theme_mode.dart';
import 'package:irri/app_theme_mode/set_app_theme_mode.dart';
import 'package:irri/auth/providers.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';

class AppState {
  const AppState({required this.themeMode});

  final ThemeMode themeMode;
}

final storageProvider = Provider<DataStorage>((ref) {
  return SharedPreferencesStorage(ref.watch(sharedPreferencesProvider));
});

// TODO(brandon): This throws `UnimplementedError` because it will always
// be overridden in `main.dart`. This is a workaround to avoid having to make
// all DataStorage-dependent providers FutureProviders.
final sharedPreferencesProvider = Provider<RxSharedPreferences>((ref) {
  throw UnimplementedError();
});

final httpClientProvider = Provider<HttpClient>((ref) {
// ignore: do_not_use_environment
  const baseUrl = String.fromEnvironment('BASE_URL');
  // ignore: close_sinks
  final interceptors = [
    // Always place LogInterceptor at the end
    LogInterceptor(logPrint: (o) => debugPrint.call(o.toString())),
  ];
  final getApiKey = ref.watch(getApiKeyProvider);
  return HttpClient(
    dio: Dio(),
    baseUrl: baseUrl,
    getAuthentication: getApiKey,
    interceptors: interceptors,
  );
});

class AppLifecycleStateNotifier extends StateNotifier<AppLifecycleState> {
  AppLifecycleStateNotifier(AppLifecycleState state) : super(state);

  // ignore: use_setters_to_change_properties
  void setLifecycleState(AppLifecycleState newState) {
    state = newState;
  }
}

final appLifecycleStateProvider = StateNotifierProvider<AppLifecycleStateNotifier, AppLifecycleState>((ref) {
  return AppLifecycleStateNotifier(AppLifecycleState.resumed);
});

final setAppThemeProvider = Provider<SetAppThemeMode>((ref) {
  return SetAppThemeMode(ref.watch(storageProvider));
});

final getAppThemeProvider = Provider<GetAppThemeMode>((ref) {
  return GetAppThemeMode(ref.watch(storageProvider));
});

class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier({
    required SetAppThemeMode setAppThemeMode,
    required GetAppThemeMode getAppThemeMode,
  })  : _setAppThemeMode = setAppThemeMode,
        _getAppThemeMode = getAppThemeMode,
        super(const AppState(themeMode: ThemeMode.system)) {
    _initAppThemeMode();
  }

  final SetAppThemeMode _setAppThemeMode;
  final GetAppThemeMode _getAppThemeMode;

  Future<void> _initAppThemeMode() async {
    final mode = await _getAppThemeMode();
    await setThemeMode(mode);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await _setAppThemeMode(mode);
    state = AppState(themeMode: mode);
  }
}

final appStateProvider = StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  return AppStateNotifier(
    setAppThemeMode: ref.watch(setAppThemeProvider),
    getAppThemeMode: ref.watch(getAppThemeProvider),
  );
});
