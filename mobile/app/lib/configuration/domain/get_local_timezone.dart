import 'package:flutter_native_timezone/flutter_native_timezone.dart';

/// Returns the user's local timezone gathered from
/// native
class GetLocalTimezone {
  Future<String> call() {
    return FlutterNativeTimezone.getLocalTimezone();
  }
}
