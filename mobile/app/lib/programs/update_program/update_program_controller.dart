part of 'update_program.dart';

class UpdateProgramController extends StateNotifier<AsyncValue<void>> {
  UpdateProgramController({
    required UpdateProgram updateProgram,
    required Ref ref,
  })  : _updateProgram = updateProgram,
        _ref = ref,
        super(const AsyncValue.data(null));

  final UpdateProgram _updateProgram;
  final Ref _ref;

  Future<void> updateProgram({
    required int programId,
    required String name,
    required List<int> frequency,
    required List<RunCreation> runGroups,
  }) async {
    try {
      state = const AsyncValue.loading();

      await _updateProgram(
        programId: programId,
        name: name,
        frequency: frequency,
        runGroups: runGroups,
      );
      // TODO(brandon): Is this the best way to do this?
      _ref.invalidate(programsProvider);
    } on Exception catch (e) {
      state = AsyncValue.error(e);
    } finally {
      state = const AsyncValue.data(null);
    }
  }
}

final updateProgramControllerProvider =
    StateNotifierProvider<UpdateProgramController, AsyncValue<void>>((ref) {
  return UpdateProgramController(
    updateProgram: ref.watch(
      updateProgramProvider,
    ),
    ref: ref,
  );
});
