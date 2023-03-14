import 'package:intl/intl.dart';

DateTime nowUtc() => DateTime.now().toUtc();

DateTime epochUtc() => DateTime.fromMicrosecondsSinceEpoch(0, isUtc: true);

extension DateTimeX on DateTime {
  String toPostgreSQLTimestampFormat() {
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    return formatter.format(this);
  }
}
