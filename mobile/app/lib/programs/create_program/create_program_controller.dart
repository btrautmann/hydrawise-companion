part of 'create_program.dart';

class CreateProgramController extends StateNotifier<AsyncValue<Object?>> {
  CreateProgramController({
    required CreateProgram createProgram,
    required Ref ref,
  })  : _createProgram = createProgram,
        _ref = ref,
        super(const AsyncData(null));

  final CreateProgram _createProgram;
  final Ref _ref;

  Future<void> createProgram({
    required String name,
    required List<int> frequency,
    required List<RunCreation> runGroups,
  }) async {
    try {
      state = const AsyncLoading();

      await _createProgram(
        name: name,
        frequency: frequency,
        runGroups: runGroups,
      );
      // TODO(brandon): Is this the best way to do this?
      _ref.invalidate(programsProvider);
      state = const AsyncData(success);
    } on Exception catch (e) {
      state = AsyncError(e, StackTrace.current);
    } finally {
      state = const AsyncData(null);
    }
  }
}

final createProgramControllerProvider = StateNotifierProvider<CreateProgramController, AsyncValue<Object?>>((ref) {
  return CreateProgramController(
    createProgram: ref.watch(
      createProgramProvider,
    ),
    ref: ref,
  );
});
