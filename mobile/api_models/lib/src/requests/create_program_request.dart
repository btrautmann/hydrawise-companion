import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_program_request.freezed.dart';
part 'create_program_request.g.dart';

@freezed
class CreateProgramRequest with _$CreateProgramRequest {
  factory CreateProgramRequest({
    @JsonKey(name: 'api_key') required String apiKey,
    @JsonKey(name: 'program_name') required String programName,
    @JsonKey(name: 'frequency') required List<int> frequency,
    @JsonKey(name: 'runs') required List<RunCreation> runs,
  }) = _CreateProgramRequest;

  factory CreateProgramRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateProgramRequestFromJson(json);
}

@freezed
class RunCreation with _$RunCreation {
  factory RunCreation({
    @JsonKey(name: 'zone_id') required int zoneId,
    @JsonKey(name: 'duration_seconds') required int durationSeconds,
    @JsonKey(name: 'start_hour') required int startHour,
    @JsonKey(name: 'start_minute') required int startMinute,
  }) = _RunCreation;

  factory RunCreation.fromJson(Map<String, dynamic> json) =>
      _$RunCreationFromJson(json);
}
