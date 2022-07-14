import 'package:api_models/api_models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_program_request.freezed.dart';
part 'update_program_request.g.dart';

@freezed
class UpdateProgramRequest with _$UpdateProgramRequest {
  factory UpdateProgramRequest({
    @JsonKey(name: 'api_key') required String apiKey,
    @JsonKey(name: 'program_id') required String programId,
    @JsonKey(name: 'program_name') required String programName,
    @JsonKey(name: 'frequency') required List<int> frequency,
    @JsonKey(name: 'runs_to_create') required List<RunCreation> runsToCreate,
    @JsonKey(name: 'runs_to_update') required List<Run> runsToUpdate,
  }) = _UpdateProgramRequest;

  factory UpdateProgramRequest.fromJson(Map<String, dynamic> json) => _$UpdateProgramRequestFromJson(json);
}
