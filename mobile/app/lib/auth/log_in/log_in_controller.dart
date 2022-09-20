part of 'log_in.dart';

class LogInController extends StateNotifier<AsyncValue<Object?>> {
  LogInController({
    required LogIn logIn,
    required Ref ref,
  })  : _logIn = logIn,
        _ref = ref,
        super(const AsyncData(null));

  final LogIn _logIn;
  final Ref _ref;

  Future<void> logIn({
    required String apiKey,
  }) async {
    try {
      state = const AsyncLoading();

      final isSuccessful = await _logIn(
        apiKey: apiKey,
      );
      if (isSuccessful) {
        // TODO(brandon): Is this the best way to do this?
        _ref.invalidate(authProvider);
      }
      state = AsyncData(isSuccessful);
    } on Exception catch (e) {
      state = AsyncError(e);
    } finally {
      state = const AsyncData(null);
    }
  }
}

final logInControllerProvider = StateNotifierProvider<LogInController, AsyncValue<void>>((ref) {
  return LogInController(
    logIn: ref.watch(
      logInProvider,
    ),
    ref: ref,
  );
});
