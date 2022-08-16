import 'db_run.dart';

class NextRunForZone {
  NextRunForZone({required this.run, required this.time});

  final DbRun run;
  final DateTime time;
}
