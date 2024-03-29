part of 'update_program.dart';

const updateProgramSuccess = Object();

class UpdateProgramController extends StateNotifier<AsyncValue<Object?>> {
  UpdateProgramController({
    required UpdateProgram updateProgram,
    required Ref ref,
  })  : _updateProgram = updateProgram,
        _ref = ref,
        super(const AsyncData(null));

  final UpdateProgram _updateProgram;
  final Ref _ref;

  Future<void> updateProgram({
    required int programId,
    required String name,
    required List<int> frequency,
    required List<RunGroupCreation> runGroups,
  }) async {
    try {
      state = const AsyncLoading();

      await _updateProgram(
        programId: programId,
        name: name,
        frequency: frequency,
        runGroups: runGroups,
      );
      // TODO(brandon): Is this the best way to do this?
      _ref
        ..invalidate(programsProvider)
        ..invalidate(zonesProvider);
      state = const AsyncData(updateProgramSuccess);
    } on Exception catch (error) {
      state = AsyncError(error, StackTrace.current);
    } finally {
      state = const AsyncData(null);
    }
  }
}

final updateProgramControllerProvider = StateNotifierProvider<UpdateProgramController, AsyncValue<Object?>>((ref) {
  return UpdateProgramController(
    updateProgram: ref.watch(
      updateProgramProvider,
    ),
    ref: ref,
  );
});
