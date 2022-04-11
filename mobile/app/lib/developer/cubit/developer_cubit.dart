import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irri/developer/developer.dart';

part 'developer_state.dart';
part 'developer_cubit.freezed.dart';

class DeveloperCubit extends Cubit<DeveloperState> {
  DeveloperCubit({
    required GetAllStorage getAllStorage,
  })  : _getAllStorage = getAllStorage,
        super(DeveloperState(storage: {})) {
    _init();
  }

  final GetAllStorage _getAllStorage;

  Future<void> _init() async {
    final storage = await _getAllStorage();
    emit(state.copyWith(storage: storage));
  }
}
