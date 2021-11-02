import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.dart';
part 'app_cubit.freezed.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState(themeMode: ThemeMode.system));

  void setThemeMode(ThemeMode mode) {
    emit(state.copyWith(themeMode: mode));
  }
}
