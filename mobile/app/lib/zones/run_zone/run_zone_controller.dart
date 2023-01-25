part of 'run_zone.dart';

class RunZoneController extends StateNotifier<AsyncValue<void>> {
  RunZoneController({
    required RunZone runZone,
    required Ref ref,
  })  : _runZone = runZone,
        _ref = ref,
        super(const AsyncValue.data(null));

  final RunZone _runZone;
  final Ref _ref;

  Future<void> runZone({
    required Zone zone,
    required int runLengthMinutes,
  }) async {
    try {
      state = const AsyncValue.loading();

      await _runZone(
        zone: zone,
        runLengthSeconds: runLengthMinutes * 60,
      );
      // TODO(brandon): Is this the best way to do this?
      _ref.invalidate(zonesProvider);
    } on Exception catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    } finally {
      state = const AsyncValue.data(null);
    }
  }
}

final runZoneControllerProvider =
    StateNotifierProvider<RunZoneController, AsyncValue<void>>((ref) {
  return RunZoneController(
    runZone: ref.watch(runZoneProvider),
    ref: ref,
  );
});
