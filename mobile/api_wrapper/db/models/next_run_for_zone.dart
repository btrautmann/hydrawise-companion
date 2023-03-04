import 'db_run.dart';

class NextRunForZone {
  NextRunForZone({
    required this.run,
    required this.time,
    required this.duration,
  });

  final DbRun run;
  final Duration duration;
  final DateTime time;
}
