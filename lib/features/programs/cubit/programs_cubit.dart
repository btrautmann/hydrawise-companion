import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrawise/features/programs/domain/delete_program.dart';
import 'package:hydrawise/features/programs/domain/get_programs.dart';
import 'package:hydrawise/features/programs/programs.dart';
import 'package:hydrawise/features/programs/view/create_program_page/run_creation.dart';

part 'programs_state.dart';
part 'programs_cubit.freezed.dart';

class ProgramsCubit extends Cubit<ProgramsState> {
  final GetPrograms _getPrograms;
  final CreateProgram _createProgram;
  final DeleteProgram _deleteProgram;

  ProgramsCubit({
    required GetPrograms getPrograms,
    required CreateProgram createProgram,
    required DeleteProgram deleteProgram,
  })  : _getPrograms = getPrograms,
        _createProgram = createProgram,
        _deleteProgram = deleteProgram,
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
    required List<RunCreation> runs,
  }) async {
    await _createProgram(
      name: name,
      frequency: frequency,
      runs: runs,
    );
    _initPrograms();
  }

  Future<void> deleteProgram({required String programId}) {
    return _deleteProgram(programId: programId);
  }
}
