import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrawise/features/app_theme_mode/app_theme_mode.dart';

part 'app_state.dart';
part 'app_cubit.freezed.dart';

class AppCubit extends Cubit<AppState> {
  final SetAppThemeMode _setAppThemeMode;
  final GetAppThemeMode _getAppThemeMode;

  AppCubit({
    required SetAppThemeMode setAppThemeMode,
    required GetAppThemeMode getAppThemeMode,
  })  : _setAppThemeMode = setAppThemeMode,
        _getAppThemeMode = getAppThemeMode,
        super(AppState(themeMode: ThemeMode.system)) {
    _initAppThemeMode();
  }

  void _initAppThemeMode() async {
    final mode = await _getAppThemeMode();
    emit(state.copyWith(themeMode: mode));
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await _setAppThemeMode(mode);
    emit(state.copyWith(themeMode: mode));
  }
}
