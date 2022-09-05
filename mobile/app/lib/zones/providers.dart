import 'package:api_models/api_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irri/app/app.dart';
import 'package:irri/auth/providers.dart';
import 'package:irri/zones/domain/get_zones.dart';
import 'package:irri/zones/zones.dart';

final runZoneProvider = Provider<RunZone>((ref) {
  return RunZone(
    httpClient: ref.watch(httpClientProvider),
  );
});

final stopZoneProvider = Provider<StopZone>((ref) {
  return StopZone(
    httpClient: ref.watch(httpClientProvider),
  );
});

final getZonesProvider = Provider<GetZones>((ref) {
  return GetZones(
    httpClient: ref.watch(httpClientProvider),
  );
});

class ZonesNotifier extends StateNotifier<AsyncValue<List<Zone>>> {
  ZonesNotifier({
    required GetZones getCustomer,
    required AuthState authState,
  })  : _getCustomer = getCustomer,
        _authState = authState,
        super(const AsyncValue.loading()) {
    _init();
  }

  final GetZones _getCustomer;
  final AuthState _authState;

  Future<void> _init() async {
    if (_authState.isLoggedIn()) {
      await _loadZones();
    }
  }

  Future<void> _loadZones() async {
    state = const AsyncValue.loading();
    try {
      final customer = await _getCustomer();
      state = AsyncValue.data(customer);
    } on Exception catch (e) {
      state = AsyncValue.error(e);
    }
  }
}

final zonesProvider = FutureProvider<List<Zone>>((ref) async {
  // TODO(brandon): Add API for fetching only zones
  final getZones = ref.watch(getZonesProvider);
  final zones = await getZones();
  return zones;
});
