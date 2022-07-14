import 'package:api_models/src/responses/get_programs_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_program_response.freezed.dart';
part 'create_program_response.g.dart';

@freezed
class CreateProgramResponse with _$CreateProgramResponse {
  factory CreateProgramResponse({
    @JsonKey(name: 'program') required Program program,
  }) = _CreateProgramResponse;

  factory CreateProgramResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateProgramResponseFromJson(json);
}
