import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrawise/features/programs/models/frequency.dart';
import 'package:hydrawise/features/programs/models/start_time.dart';

part 'program.freezed.dart';

@freezed
class Program with _$Program {
  factory Program({
    required String name, // PRIMARY ID in `programs`
    required Frequency frequency, // INTEGER COLUMN in `programs` (0/1)
    required List<StartTime> startTimes, // `program_start_times`
  }) = _Program;

  static Program fromJson(Map<String, dynamic> json) {
    return Program(
      name: json['name'] as String,
      frequency: Frequency(
        monday: (json['monday'] as int) == 1,
        tuesday: (json['tuesday'] as int) == 1,
        wednesday: (json['wednesday'] as int) == 1,
        thursday: (json['thursday'] as int) == 1,
        friday: (json['friday'] as int) == 1,
        saturday: (json['saturday'] as int) == 1,
        sunday: (json['sunday'] as int) == 1,
      ),
      startTimes: [],
    );
  }
}

extension ProgramX on Program {
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'monday': frequency.monday ? 1 : 0,
      'tuesday': frequency.tuesday ? 1 : 0,
      'wednesday': frequency.wednesday ? 1 : 0,
      'thursday': frequency.thursday ? 1 : 0,
      'friday': frequency.friday ? 1 : 0,
      'saturday': frequency.saturday ? 1 : 0,
      'sunday': frequency.sunday ? 1 : 0,
    };
  }
}
