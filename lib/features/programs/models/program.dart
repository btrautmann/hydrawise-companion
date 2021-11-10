import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrawise/features/programs/models/frequency.dart';
import 'package:hydrawise/features/programs/models/run.dart';

part 'program.freezed.dart';

@freezed
class Program with _$Program {
  factory Program({
    required String id,
    required String name,
    required Frequency frequency,
    required List<Run> runs,
  }) = _Program;
}

extension ProgramX on Program {
  static Map<String, dynamic> toJson(Program program) {
    return {
      'id': program.id,
      'name': program.name,
      'monday': program.frequency.monday ? 1 : 0,
      'tuesday': program.frequency.tuesday ? 1 : 0,
      'wednesday': program.frequency.wednesday ? 1 : 0,
      'thursday': program.frequency.thursday ? 1 : 0,
      'friday': program.frequency.friday ? 1 : 0,
      'saturday': program.frequency.saturday ? 1 : 0,
      'sunday': program.frequency.sunday ? 1 : 0,
    };
  }

  static Program fromJson(Map<String, dynamic> json) {
    return Program(
      id: json['id'] as String,
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
      runs: [],
    );
  }
}