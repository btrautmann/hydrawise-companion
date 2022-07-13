import 'package:freezed_annotation/freezed_annotation.dart';

part 'run_zone_request.freezed.dart';
part 'run_zone_request.g.dart';

@freezed
class RunZoneRequest with _$RunZoneRequest {
  factory RunZoneRequest({
    @JsonKey(name: 'api_key') required String apiKey,
    @JsonKey(name: 'zone_id') required int zoneId,
    @JsonKey(name: 'run_length_seconds') required int runLengthSeconds,
  }) = _RunZoneRequest;

  factory RunZoneRequest.fromJson(Map<String, dynamic> json) =>
      _$RunZoneRequestFromJson(json);
}
