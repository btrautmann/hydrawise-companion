part of 'log_in.dart';

class LogInController extends StateNotifier<AsyncValue<void>> {
  LogInController({
    required LogIn logIn,
    required Ref ref,
  })  : _logIn = logIn,
        _ref = ref,
        super(const AsyncValue.data(null));

  final LogIn _logIn;
  final Ref _ref;

  Future<void> logIn({
    required String apiKey,
  }) async {
    try {
      state = const AsyncValue.loading();

      await _logIn(
        apiKey: apiKey,
      );
      // TODO(brandon): Is this the best way to do this?
      _ref.invalidate(authProvider);
    } on Exception catch (e) {
      state = AsyncValue.error(e);
    } finally {
      state = const AsyncValue.data(null);
    }
  }
}

final logInControllerProvider =
    StateNotifierProvider<LogInController, AsyncValue<void>>((ref) {
  return LogInController(
    logIn: ref.watch(
      logInProvider,
    ),
    ref: ref,
  );
});
