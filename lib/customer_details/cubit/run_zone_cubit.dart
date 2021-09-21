import 'package:bloc/bloc.dart';
import 'package:hydrawise/customer_details/cubit/run_zone_state.dart';
import 'package:hydrawise/customer_details/domain/run_zone.dart';
import 'package:hydrawise/customer_details/domain/stop_zone.dart';
import 'package:hydrawise/customer_details/models/zone.dart';

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
    await _runZone(
      zone: _zone,
      runLengthSeconds: runLengthMinutes * 60,
    );
    emit(RunZoneState.resting());
  }

  Future<void> stopZone() async {
    emit(RunZoneState.loading());
    await _stopZone(
      zone: _zone,
    );
    emit(RunZoneState.resting());
  }
}
