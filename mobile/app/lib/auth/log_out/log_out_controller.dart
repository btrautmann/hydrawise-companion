part of 'log_out.dart';

class LogOutController extends StateNotifier<AsyncValue<void>> {
  LogOutController({
    required LogOut logOut,
    required Ref ref,
  })  : _logOut = logOut,
        _ref = ref,
        super(const AsyncValue.data(null));

  final LogOut _logOut;
  final Ref _ref;

  Future<void> logOut() async {
    try {
      state = const AsyncValue.loading();

      await _logOut();
      // TODO(brandon): Is this the best way to do this?
      _ref.invalidate(authProvider);
    } on Exception catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    } finally {
      state = const AsyncValue.data(null);
    }
  }
}

final logOutControllerProvider =
    StateNotifierProvider<LogOutController, AsyncValue<void>>((ref) {
  return LogOutController(
    logOut: ref.watch(logOutProvider),
    ref: ref,
  );
});
