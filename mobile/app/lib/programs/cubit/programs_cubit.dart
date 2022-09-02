import 'package:api_models/api_models.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irri/programs/domain/domain.dart';

part 'programs_cubit.freezed.dart';
part 'programs_state.dart';

class ProgramsCubit extends Cubit<ProgramsState> {
  ProgramsCubit({
    required GetPrograms getPrograms,
    required CreateProgram createProgram,
    required UpdateProgram updateProgram,
    required DeleteProgram deleteProgram,
  })  : _getPrograms = getPrograms,
        _createProgram = createProgram,
        _updateProgram = updateProgram,
        _deleteProgram = deleteProgram,
        super(ProgramsState(programs: [])) {
    _initPrograms();
  }

  final GetPrograms _getPrograms;
  final CreateProgram _createProgram;
  final UpdateProgram _updateProgram;
  final DeleteProgram _deleteProgram;

  Future<void> _initPrograms() async {
    final getProgramsResponse = await _getPrograms();
    emit(
      state.copyWith(
        programs: getProgramsResponse.isSuccess ? getProgramsResponse.success.programs : List.empty(),
      ),
    );
  }

  Future<void> createProgram({
    required String name,
    required List<int> frequency,
    required List<RunCreation> runGroups,
  }) async {
    await _createProgram(
      name: name,
      frequency: frequency,
      runGroups: runGroups,
    );
    await _initPrograms();
  }

  void addToPendingDeletes(Program program) {
    final pending = List.of(state.pendingDeletes)..add(program);
    final programs = List.of(state.programs)..retainWhere((p) => p.id != program.id);
    emit(
      state.copyWith(
        programs: programs,
        pendingDeletes: pending,
      ),
    );
  }

  void resetPrograms() {
    final programs = <Program>[...state.pendingDeletes, ...state.programs];
    emit(
      state.copyWith(
        programs: programs,
        pendingDeletes: [],
      ),
    );
  }

  Future<void> deletePending() async {
    for (final program in state.pendingDeletes) {
      await deleteProgram(programId: program.id);
    }
    emit(state.copyWith(pendingDeletes: []));
  }

  Future<void> updateProgram({
    required int programId,
    required String name,
    required List<int> frequency,
    required List<RunCreation> runs,
  }) async {
    await _updateProgram(
      programId: programId,
      name: name,
      frequency: frequency,
      runGroups: runs,
    );
    await _initPrograms();
  }

  Future<void> deleteProgram({required int programId}) async {
    await _deleteProgram(programId: programId);
    await _initPrograms();
  }
}
