import 'dart:async';

import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irri/app/app.dart';
import 'package:irri/app_theme_mode/domain/domain.dart';
import 'package:irri/auth/providers.dart';

part 'providers.freezed.dart';

@freezed
class AppState with _$AppState {
  factory AppState({required ThemeMode themeMode}) = _AppState;
}

// ignore: prefer_void_to_null
final authFailuresProvider = Provider<StreamController<Null>>((ref) {
  return StreamController();
});

final storageProvider = Provider<DataStorage>((ref) {
  return InMemoryStorage();
});

final httpClientProvider = Provider<HttpClient>((ref) {
// ignore: do_not_use_environment
  const baseUrl = String.fromEnvironment('BASE_URL');
  // ignore: close_sinks
  final authFailures = ref.watch(authFailuresProvider);
  final interceptors = [
    AuthenticationInterceptor(
      onAuthenticationFailure: () => authFailures.add(null),
    ),
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
        super(AppState(themeMode: ThemeMode.system)) {
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
    state = state.copyWith(themeMode: mode);
  }
}

final appStateProvider = StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  return AppStateNotifier(
    setAppThemeMode: ref.watch(setAppThemeProvider),
    getAppThemeMode: ref.watch(getAppThemeProvider),
  );
});
