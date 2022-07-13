// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_programs_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GetProgramsResponse _$$_GetProgramsResponseFromJson(Map json) =>
    _$_GetProgramsResponse(
      programs: (json['programs'] as List<dynamic>)
          .map((e) => Program.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$$_GetProgramsResponseToJson(
        _$_GetProgramsResponse instance) =>
    <String, dynamic>{
      'programs': instance.programs.map((e) => e.toJson()).toList(),
    };

_$_Program _$$_ProgramFromJson(Map json) => _$_Program(
      id: json['id'] as String,
      name: json['name'] as String,
      frequency:
          (json['frequency'] as List<dynamic>).map((e) => e as int).toList(),
      runs: (json['runs'] as List<dynamic>)
          .map((e) => Run.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$$_ProgramToJson(_$_Program instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'frequency': instance.frequency,
      'runs': instance.runs.map((e) => e.toJson()).toList(),
    };

_$_Run _$$_RunFromJson(Map json) => _$_Run(
      id: json['id'] as String,
      programId: json['program_id'] as String,
      zoneId: json['zone_id'] as int,
      durationSeconds: json['duration_sec'] as int,
      startTime: json['start_time'] as String,
    );

Map<String, dynamic> _$$_RunToJson(_$_Run instance) => <String, dynamic>{
      'id': instance.id,
      'program_id': instance.programId,
      'zone_id': instance.zoneId,
      'duration_sec': instance.durationSeconds,
      'start_time': instance.startTime,
    };
