part of 'update_zone.dart';

class UpdateZoneController extends StateNotifier<AsyncValue<Object?>> {
  UpdateZoneController({
    required UpdateZone updateZone,
    required Ref ref,
  })  : _updateZone = updateZone,
        _ref = ref,
        super(const AsyncValue.data(null));

  final UpdateZone _updateZone;
  final Ref _ref;

  Future<void> updateZone({
    required Zone zone,
    required String name,
  }) async {
    try {
      state = const AsyncValue.loading();

      final isSuccessful = await _updateZone(zone: zone, name: name);
      // TODO(brandon): Is this the best way to do this?
      unawaited(_ref.read(zonesStoreProvider).fresh('zones'));
      state = AsyncData(isSuccessful);
    } on Exception catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    } finally {
      state = const AsyncValue.data(null);
    }
  }
}

final updateZoneControllerProvider = StateNotifierProvider<UpdateZoneController, AsyncValue<void>>((ref) {
  return UpdateZoneController(
    updateZone: ref.watch(updateZoneProvider),
    ref: ref,
  );
});
