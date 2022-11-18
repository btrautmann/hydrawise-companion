import 'dart:async';
import 'dart:convert';

import 'package:api_models/api_models.dart';
import 'package:flutter/material.dart';
import 'package:gooder_store/gooder_store.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:irri/app/providers.dart';
import 'package:irri/auth/providers.dart';
import 'package:irri/zones/domain/get_zones.dart';
import 'package:irri/zones/run_zone/run_zone.dart';
import 'package:irri/zones/stop_zone/stop_zone.dart';
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

final getZonesProvider = Provider<GetZones>((ref) {
  return GetZones(
    httpClient: ref.watch(httpClientProvider),
  );
});

final zoneRefreshIntervalProvider = Provider<Duration?>((ref) {
  final lifecycleState = ref.watch(appLifecycleStateProvider);
  if (lifecycleState == AppLifecycleState.resumed) {
    return const Duration(
      seconds: 60,
    );
  }
  return null;
});

final zonesStoreProvider = Provider<Store<void, List<Zone>>>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return Store.from(
    fetch: (_) => Stream.fromFuture(ref.watch(getZonesProvider).call()),
    sourceOfTruth: SourceOfTruth.of(
      read: (key) => prefs.getStringStream(key.toString()).map(
        (event) {
          if (event == null) {
            return List<Zone>.empty();
          }
          final list = jsonDecode(event) as List<dynamic>;
          final zones = list.map((e) => Zone.fromJson(e as Map<String, dynamic>));
          return zones.toList();
        },
      ),
      write: (key, value) async => prefs.setString(
        key.toString(),
        jsonEncode(value.map((e) => e.toJson()).toList()),
      ),
      delete: (key) async => prefs.remove(key.toString()),
      deleteAll: () async => prefs.clear(),
    ),
  );
});

class ZonesNotifier extends StateNotifier<AsyncValue<List<Zone>>> {
  ZonesNotifier({
    required Store<void, List<Zone>> getCustomer,
    required AuthState authState,
    required Duration? refreshInterval,
  })  : _zonesStore = getCustomer,
        _authState = authState,
        _refreshInterval = refreshInterval,
        super(const AsyncValue.loading()) {
    _init();
  }

  final Store<void, List<Zone>> _zonesStore;
  final AuthState _authState;
  final Duration? _refreshInterval;
  Timer? _timer;

  Future<void> _init() async {
    if (_authState.isAuthenticated && _refreshInterval != null) {
      await _loadZones();
      _timer = Timer.periodic(_refreshInterval!, (timer) {
        _loadZones();
      });
    }
  }

  Future<void> _loadZones() async {
    state = const AsyncValue.loading();
    try {
      final response = _zonesStore.fresh(null);
      state = AsyncValue.data((response as Data<List<Zone>>).value);
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
    getCustomer: ref.watch(zonesStoreProvider),
    authState: ref.watch(authProvider),
    refreshInterval: ref.watch(zoneRefreshIntervalProvider),
  );
});
