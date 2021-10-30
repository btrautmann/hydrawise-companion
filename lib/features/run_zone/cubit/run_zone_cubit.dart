import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrawise/features/customer_details/customer_details.dart';
import 'package:hydrawise/features/run_zone/run_zone.dart';

part 'run_zone_state.dart';
part 'run_zone_cubit.freezed.dart';

class RunZoneCubit extends Cubit<RunZoneState> {
  RunZoneCubit({
    required RunZone runZone,
    required StopZone stopZone,
    required Zone zone,
  })  : _runZone = runZone,
        _stopZone = stopZone,
        _zone = zone,
        super(RunZoneState.resting());

  final RunZone _runZone;
  final StopZone _stopZone;
  final Zone _zone;

  Future<void> runZone({required int runLengthMinutes}) async {
    emit(RunZoneState.loading());
    final result = await _runZone(
      zone: _zone,
      runLengthSeconds: runLengthMinutes * 60,
    );

    final message = result.isFailure ? result.failure : result.success.message;
    emit(RunZoneState.resting(message: message));
  }

  Future<void> stopZone() async {
    emit(RunZoneState.loading());
    final result = await _stopZone(
      zone: _zone,
    );
    final message = result.isFailure ? result.failure : result.success.message;
    emit(RunZoneState.resting(message: message));
  }
}
