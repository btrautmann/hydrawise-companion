import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeState {
  const HomeState({required this.selectedTabIndex});
  final int selectedTabIndex;
}

class HomeStateNotifier extends StateNotifier<HomeState> {
  HomeStateNotifier() : super(const HomeState(selectedTabIndex: 0));

  void selectTab(int selectedTabIndex) {
    state = HomeState(selectedTabIndex: selectedTabIndex);
  }
}

final homeStateProvider = StateNotifierProvider<HomeStateNotifier, HomeState>((ref) {
  return HomeStateNotifier();
});
