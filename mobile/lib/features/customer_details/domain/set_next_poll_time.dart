import 'package:clock/clock.dart';
import 'package:irri/core/core.dart';

typedef SetNextPollTime = Future<void> Function({
  required int secondsUntilNextPoll,
});

class SetNextPollTimeInStorage {
  SetNextPollTimeInStorage(this._dataStorage);

  final DataStorage _dataStorage;

  Future<void> call({required int secondsUntilNextPoll}) {
    // Store nextPollTime as millisecondsSinceEpoch
    // TODO(brandon): Use a framework we can
    // modify under test for time
    final nextPollTime =
        clock.now().millisecondsSinceEpoch + (secondsUntilNextPoll * 1000);

    return _dataStorage.setInt('next_poll_time', nextPollTime);
  }
}
