import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(selectedTabIndex: 0));

  void selectTab(int selectedTabIndex) {
    emit(state.copyWith(selectedTabIndex: selectedTabIndex));
  }
}
