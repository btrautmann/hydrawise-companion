// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_program_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CreateProgramRequest _$$_CreateProgramRequestFromJson(Map json) =>
    _$_CreateProgramRequest(
      apiKey: json['api_key'] as String,
      programName: json['program_name'] as String,
      frequency:
          (json['frequency'] as List<dynamic>).map((e) => e as int).toList(),
      runs: (json['runs'] as List<dynamic>)
          .map((e) => RunCreation.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$$_CreateProgramRequestToJson(
        _$_CreateProgramRequest instance) =>
    <String, dynamic>{
      'api_key': instance.apiKey,
      'program_name': instance.programName,
      'frequency': instance.frequency,
      'runs': instance.runs.map((e) => e.toJson()).toList(),
    };

_$_RunCreation _$$_RunCreationFromJson(Map json) => _$_RunCreation(
      zoneId: json['zone_id'] as int,
      durationSeconds: json['duration_seconds'] as int,
      startTime: json['start_time'] as String,
    );

Map<String, dynamic> _$$_RunCreationToJson(_$_RunCreation instance) =>
    <String, dynamic>{
      'zone_id': instance.zoneId,
      'duration_seconds': instance.durationSeconds,
      'start_time': instance.startTime,
    };
