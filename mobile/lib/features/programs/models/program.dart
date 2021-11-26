import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrawise/features/programs/models/run.dart';

part 'program.freezed.dart';
part 'program.g.dart';

@freezed
class Program with _$Program {
  factory Program({
    required String id,
    required String name,
    required List<int> frequency,
    @JsonKey(ignore: true) List<Run>? runs,
  }) = _Program;

  factory Program.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ProgramFromJson(json);
}

extension ListProgramX on List<Program> {
  /// Returns the runs that will run today,
  /// if any
  List<Run> todayRuns() {
    final now = DateTime.now();
    final dayOfWeek = now.weekday;
    final todayPrograms =
        where((element) => element.frequency.contains(dayOfWeek));
    return todayPrograms
        .expand(
          (element) => element.runs?.where(
            (element) => element.startTime.isAfter(now),
          ) ?? List<Run>.empty(),
        )
        .toList();
  }
}
