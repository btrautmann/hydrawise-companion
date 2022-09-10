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

      final success = await _logIn(
        apiKey: apiKey,
      );
      if (success) {
        // TODO(brandon): Is this the best way to do this?
        _ref.invalidate(authProvider);
      }
      state = AsyncData(success);
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
