import 'package:freezed_annotation/freezed_annotation.dart';

part 'run_zone_response.freezed.dart';
part 'run_zone_response.g.dart';

@freezed
class RunZoneResponse with _$RunZoneResponse {
  factory RunZoneResponse({
    @JsonKey(name: 'message') required String message,
    @JsonKey(name: 'message_type') required String typeOfMessage,
  }) = _RunZoneResponse;

  factory RunZoneResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$RunZoneResponseFromJson(json);
}
