import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrawise/features/programs/domain/get_programs.dart';
import 'package:hydrawise/features/programs/programs.dart';

part 'programs_state.dart';
part 'programs_cubit.freezed.dart';

class ProgramsCubit extends Cubit<ProgramsState> {
  final GetPrograms _getPrograms;
  final CreateProgram _createProgram;

  ProgramsCubit({
    required GetPrograms getPrograms,
    required CreateProgram createProgram,
  })  : _getPrograms = getPrograms,
        _createProgram = createProgram,
        super(ProgramsState(programs: [])) {
    _initPrograms();
  }

  Future<void> _initPrograms() async {
    final programs = await _getPrograms();
    emit(state.copyWith(programs: programs));
  }

  Future<void> createProgram({
    required String name,
    required Frequency frequency,
    required List<Run> runs,
  }) async {
    await _createProgram(
      name: name,
      frequency: frequency,
      runs: runs,
    );
    _initPrograms();
  }
}
