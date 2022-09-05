part of 'create_program.dart';

class CreateProgramController extends StateNotifier<AsyncValue<void>> {
  CreateProgramController({
    required CreateProgram createProgram,
    required Ref ref,
  })  : _createProgram = createProgram,
        _ref = ref,
        super(const AsyncValue.data(null));

  final CreateProgram _createProgram;
  final Ref _ref;

  Future<void> createProgram({
    required String name,
    required List<int> frequency,
    required List<RunCreation> runGroups,
  }) async {
    try {
      state = const AsyncValue.loading();

      await _createProgram(
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

final createProgramControllerProvider = StateNotifierProvider<CreateProgramController, AsyncValue<void>>((ref) {
  return CreateProgramController(
    createProgram: ref.watch(
      createProgramProvider,
    ),
    ref: ref,
  );
});
