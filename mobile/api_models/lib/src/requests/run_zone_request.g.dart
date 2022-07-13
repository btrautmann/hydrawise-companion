// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'run_zone_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RunZoneRequest _$$_RunZoneRequestFromJson(Map json) => _$_RunZoneRequest(
      apiKey: json['api_key'] as String,
      zoneId: json['zone_id'] as int,
      runLengthSeconds: json['run_length_seconds'] as int,
    );

Map<String, dynamic> _$$_RunZoneRequestToJson(_$_RunZoneRequest instance) =>
    <String, dynamic>{
      'api_key': instance.apiKey,
      'zone_id': instance.zoneId,
      'run_length_seconds': instance.runLengthSeconds,
    };
