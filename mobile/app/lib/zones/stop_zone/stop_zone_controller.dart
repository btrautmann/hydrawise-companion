part of 'stop_zone.dart';

class StopZoneController extends StateNotifier<AsyncValue<void>> {
  StopZoneController({
    required StopZone stopZone,
    required Ref ref,
  })  : _stopZone = stopZone,
        _ref = ref,
        super(const AsyncValue.data(null));

  final StopZone _stopZone;
  final Ref _ref;

  Future<void> stopZone({
    required Zone zone,
  }) async {
    try {
      state = const AsyncValue.loading();

      await _stopZone(zone: zone);
      // TODO(brandon): Is this the best way to do this?
      _ref.invalidate(zonesProvider);
    } on Exception catch (e) {
      state = AsyncValue.error(e);
    } finally {
      state = const AsyncValue.data(null);
    }
  }
}

final stopZoneControllerProvider =
    StateNotifierProvider<StopZoneController, AsyncValue<void>>((ref) {
  return StopZoneController(
    stopZone: ref.watch(stopZoneProvider),
    ref: ref,
  );
});
