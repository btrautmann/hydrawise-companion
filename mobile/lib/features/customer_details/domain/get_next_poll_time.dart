import 'package:irri/core/core.dart';

typedef GetNextPollTime = Future<DateTime> Function();

class GetNextPollTimeFromStorage {
  GetNextPollTimeFromStorage(this._dataStorage);

  final DataStorage _dataStorage;

  Future<DateTime> call() async {
    final nextPollTime = await _dataStorage.getInt('next_poll_time');
    if (nextPollTime == null) {
      // We've never polled before, so return epoch time
      // to indicate we should poll now
      return DateTime.fromMillisecondsSinceEpoch(0);
    }
    return DateTime.fromMillisecondsSinceEpoch(nextPollTime);
  }
}
