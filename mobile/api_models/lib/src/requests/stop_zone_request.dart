import 'package:freezed_annotation/freezed_annotation.dart';

part 'stop_zone_request.freezed.dart';
part 'stop_zone_request.g.dart';

@freezed
class StopZoneRequest with _$StopZoneRequest {
  factory StopZoneRequest({
    @JsonKey(name: 'api_key') required String apiKey,
    @JsonKey(name: 'zone_id') required int zoneId,
  }) = _StopZoneRequest;

  factory StopZoneRequest.fromJson(Map<String, dynamic> json) =>
      _$StopZoneRequestFromJson(json);
}
