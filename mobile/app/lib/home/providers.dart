import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'providers.freezed.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({required int selectedTabIndex}) = _HomeState;
}

class HomeStateNotifier extends StateNotifier<HomeState> {
  HomeStateNotifier() : super(HomeState(selectedTabIndex: 0));

  void selectTab(int selectedTabIndex) {
    state = state.copyWith(selectedTabIndex: selectedTabIndex);
  }
}

final homeStateProvider =
    StateNotifierProvider<HomeStateNotifier, HomeState>((ref) {
  return HomeStateNotifier();
});
