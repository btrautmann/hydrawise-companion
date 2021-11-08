part of 'programs_cubit.dart';

@freezed
class ProgramsState with _$ProgramsState {
  factory ProgramsState({
    required List<Program> programs,
  }) = _ProgramsState;
}
