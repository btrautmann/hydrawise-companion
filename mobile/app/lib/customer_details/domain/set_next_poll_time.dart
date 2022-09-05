import 'package:clock/clock.dart';
import 'package:core/core.dart';

class SetNextPollTime {
  SetNextPollTime(this._dataStorage);

  final DataStorage _dataStorage;

  Future<void> call({required int secondsUntilNextPoll}) {
    // Store nextPollTime as millisecondsSinceEpoch
    final nextPollTime =
        clock.now().millisecondsSinceEpoch + (secondsUntilNextPoll * 1000);

    return _dataStorage.setInt('next_poll_time', nextPollTime);
  }
}
