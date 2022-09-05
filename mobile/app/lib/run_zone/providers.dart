import 'package:api_models/api_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irri/app/app.dart';
import 'package:irri/customer_details/customer_details.dart';
import 'package:irri/run_zone/run_zone.dart';

part 'providers.freezed.dart';

@freezed
class RunZoneState with _$RunZoneState {
  factory RunZoneState.resting({String? message}) = _Resting;

  factory RunZoneState.loading() = _Loading;
}

final runZoneProvider = Provider<RunZone>((ref) {
  return RunZone(
    httpClient: ref.watch(httpClientProvider),
    setNextPollTime: ref.watch(setNextPollTimeProvider),
    repository: ref.watch(customerDetailsRepositoryProvider),
  );
});

final stopZoneProvider = Provider<StopZone>((ref) {
  return StopZone(
    httpClient: ref.watch(httpClientProvider),
    repository: ref.watch(customerDetailsRepositoryProvider),
  );
});

class RunZoneNotifier extends StateNotifier<RunZoneState> {
  RunZoneNotifier({
    required RunZone runZone,
    required StopZone stopZone,
  })  : _runZone = runZone,
        _stopZone = stopZone,
        super(RunZoneState.resting());

  final RunZone _runZone;
  final StopZone _stopZone;

  Future<void> runZone({
    required Zone zone,
    required int runLengthMinutes,
  }) async {
    state = RunZoneState.loading();
    // ignore: unused_local_variable
    final result = await _runZone(
      zone: zone,
      runLengthSeconds: runLengthMinutes * 60,
    );

    const message = 'TODO';
    state = RunZoneState.resting(message: message);
  }

  Future<void> stopZone({
    required Zone zone,
  }) async {
    state = RunZoneState.loading();
    // ignore: unused_local_variable
    final result = await _stopZone(
      zone: zone,
    );
    const message = 'TODO';
    state = RunZoneState.resting(message: message);
  }
}

final runZoneStateProvider = StateNotifierProvider<RunZoneNotifier, RunZoneState>((ref) {
  return RunZoneNotifier(
    runZone: ref.watch(runZoneProvider),
    stopZone: ref.watch(stopZoneProvider),
  );
});
