import 'package:bloc/bloc.dart';
import 'package:hydrawise/customer_details/cubit/run_zone_state.dart';
import 'package:hydrawise/customer_details/domain/run_zone.dart';
import 'package:hydrawise/customer_details/models/zone.dart';

class RunZoneCubit extends Cubit<RunZoneState> {
  RunZoneCubit({
    required RunZone runZone,
    required Zone zone,
  })  : _runZone = runZone,
        _zone = zone,
        super(RunZoneState.resting());

  final RunZone _runZone;
  final Zone _zone;

  Future<void> runZone({required int runLengthInSeconds}) async {
    emit(RunZoneState.loading());
    await _runZone(zone: _zone, runLengthSeconds: runLengthInSeconds);
    emit(RunZoneState.resting());
  }
}
