import 'package:api_models/src/responses/get_programs_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_program_response.freezed.dart';
part 'update_program_response.g.dart';

@freezed
class UpdateProgramResponse with _$UpdateProgramResponse {
  factory UpdateProgramResponse({
    @JsonKey(name: 'program') required Program program,
  }) = _UpdateProgramResponse;

  factory UpdateProgramResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateProgramResponseFromJson(json);
}
