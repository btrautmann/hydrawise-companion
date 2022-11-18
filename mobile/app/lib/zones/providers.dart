import 'dart:async';

import 'package:api_models/api_models.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:irri/app/providers.dart';
import 'package:irri/auth/providers.dart';
import 'package:irri/zones/domain/get_zones.dart';
import 'package:irri/zones/run_zone/run_zone.dart';
import 'package:irri/zones/stop_zone/stop_zone.dart';

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

class ZonesNotifier extends StateNotifier<AsyncValue<List<Zone>>> {
  ZonesNotifier({
    required GetZones getCustomer,
    required AuthState authState,
    required Duration? refreshInterval,
  })  : _getZones = getCustomer,
        _authState = authState,
        _refreshInterval = refreshInterval,
        super(const AsyncValue.loading()) {
    _init();
  }

  final GetZones _getZones;
  final AuthState _authState;
  final Duration? _refreshInterval;
  Timer? _timer;

  Future<void> _init() async {
    if (_authState.isLoggedIn() && _refreshInterval != null) {
      await _loadZones();
      _timer = Timer.periodic(_refreshInterval!, (timer) {
        _loadZones();
      });
    }
  }

  Future<void> _loadZones() async {
    state = const AsyncValue.loading();
    try {
      final zones = await _getZones();
      state = AsyncValue.data(zones);
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
    getCustomer: ref.watch(getZonesProvider),
    authState: ref.watch(authProvider),
    refreshInterval: ref.watch(zoneRefreshIntervalProvider),
  );
});
