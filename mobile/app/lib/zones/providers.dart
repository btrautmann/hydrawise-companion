import 'dart:async';
import 'dart:convert';

import 'package:api_models/api_models.dart';
import 'package:flutter/material.dart';
import 'package:gooder_store/gooder_store.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:irri/app/providers.dart';
import 'package:irri/auth/providers.dart';
import 'package:irri/zones/get_zones.dart';
import 'package:irri/zones/run_zone/run_zone.dart';
import 'package:irri/zones/stop_zone/stop_zone.dart';
import 'package:irri/zones/update_zone/update_zone.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';

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

final updateZoneProvider = Provider<UpdateZone>((ref) {
  return UpdateZone(
    httpClient: ref.watch(httpClientProvider),
  );
});

final getZonesProvider = Provider<GetZones>((ref) {
  return GetZones(
    httpClient: ref.watch(httpClientProvider),
  );
});

final zoneRefreshIntervalProvider = Provider<Duration?>((ref) {
  final lifecycleState = ref.watch(appLifecycleStateProvider);
  if (lifecycleState == AppLifecycleState.resumed) {
    return const Duration(minutes: 1);
  }
  return null;
});

const _zonesKey = 'zones';

// TODO(brandon): Consider a Store that can return a single Zone, which would allow
// more granular invalidation. It could be backed by prefs, since no true endpoint
// exists for a single zone.
final zonesStoreProvider = Provider<Store<String, List<Zone>>>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return Store.from(
    fetch: (_) => Stream.fromFuture(ref.watch(getZonesProvider).call()),
    sourceOfTruth: SourceOfTruth.of(
      read: (key) => prefs.getStringStream(key).map((json) => json.toZones()),
      write: (key, value) async => prefs.setString(key, jsonEncode(value.map((e) => e.toJson()).toList())),
      delete: (key) async => prefs.remove(key),
      deleteAll: () async => prefs.clear(),
    ),
  );
});

extension on String? {
  List<Zone> toZones() {
    if (this == null) {
      return List<Zone>.empty();
    }
    final list = jsonDecode(this!) as List<dynamic>;
    final zones = list.map((e) => Zone.fromJson(e as Map<String, dynamic>));
    return zones.toList();
  }
}

class ZonesNotifier extends StateNotifier<AsyncValue<List<Zone>>> {
  ZonesNotifier({
    required Store<String, List<Zone>> zonesStore,
    required AuthState authState,
    required Duration? refreshInterval,
  })  : _zonesStore = zonesStore,
        _authState = authState,
        _refreshInterval = refreshInterval,
        super(const AsyncValue.loading()) {
    _init();
  }

  final Store<String, List<Zone>> _zonesStore;
  final AuthState _authState;
  final Duration? _refreshInterval;
  Timer? _timer;

  Future<void> _init() async {
    if (_authState.isAuthenticated && _refreshInterval != null) {
      unawaited(_streamZones());
      _timer = Timer.periodic(_refreshInterval!, (timer) {
        _zonesStore.fresh(_zonesKey);
      });
    }
  }

  Future<void> _streamZones() async {
    state = const AsyncValue.loading();
    try {
      _zonesStore.stream(request: StoreRequest.cached(key: _zonesKey, refresh: true)).listen((event) {
        if (event is Data<List<Zone>>) {
          state = AsyncValue.data(event.value);
        } else if (event is Error<List<Zone>>) {
          state = AsyncValue.error(event.error.toString());
        }
      });
    } on Exception catch (e) {
      state = AsyncValue.error(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }
}

final zonesProvider = StateNotifierProvider<ZonesNotifier, AsyncValue<List<Zone>>>((ref) {
  return ZonesNotifier(
    zonesStore: ref.watch(zonesStoreProvider),
    authState: ref.watch(authProvider),
    refreshInterval: ref.watch(zoneRefreshIntervalProvider),
  );
});
