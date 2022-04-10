import 'package:flutter_native_timezone/flutter_native_timezone.dart';

/// Returns a list of timezones available for the user
/// to select as their desired timezone to change
/// the time offset the server utilizes in determining
/// when to trigger runs
class GetAvailableTimezones {
  Future<List<String>> call() {
    return FlutterNativeTimezone.getAvailableTimezones();
  }
}
