import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_programs_response.freezed.dart';
part 'get_programs_response.g.dart';

@freezed
class GetProgramsResponse with _$GetProgramsResponse {
  factory GetProgramsResponse({
    @JsonKey(name: 'programs') required List<Program> programs,
  }) = _GetProgramsResponse;

  factory GetProgramsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetProgramsResponseFromJson(json);
}

@freezed
class Program with _$Program {
  factory Program({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'frequency') required List<int> frequency,
    @JsonKey(name: 'runs') required List<Run> runs,
  }) = _Program;

  factory Program.fromJson(Map<String, dynamic> json) =>
      _$ProgramFromJson(json);
}

@freezed
class Run with _$Run {
  factory Run({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'program_id') required String programId,
    @JsonKey(name: 'zone_id') required int zoneId,
    @JsonKey(name: 'duration_sec') required int durationSeconds,
    @JsonKey(name: 'start_hour') required int startHour,
    @JsonKey(name: 'start_minute') required int startMinute,
  }) = _Run;

  factory Run.fromJson(Map<String, dynamic> json) => _$RunFromJson(json);
}
