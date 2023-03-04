part of 'delete_program.dart';

const deleteProgramSuccess = Object();

class CreateProgramController extends StateNotifier<AsyncValue<Object?>> {
  CreateProgramController({
    required DeleteProgram deleteProgram,
    required Ref ref,
  })  : _deleteProgram = deleteProgram,
        _ref = ref,
        super(const AsyncData(null));

  final DeleteProgram _deleteProgram;
  final Ref _ref;

  Future<void> deleteProgram({required int programId}) async {
    try {
      state = const AsyncLoading();

      final isSuccessful = await _deleteProgram(programId: programId);
      if (isSuccessful) {
        // TODO(brandon): Is this the best way to do this?
        _ref
          ..invalidate(programsProvider)
          ..invalidate(zonesProvider);
        state = const AsyncData(deleteProgramSuccess);
      }
    } on Exception catch (e) {
      state = AsyncError(e, StackTrace.current);
    } finally {
      state = const AsyncData(null);
    }
  }
}

final deleteProgramControllerProvider = StateNotifierProvider<CreateProgramController, AsyncValue<Object?>>((ref) {
  return CreateProgramController(
    deleteProgram: ref.watch(deleteProgramProvider),
    ref: ref,
  );
});
