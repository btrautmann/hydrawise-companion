// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_program_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UpdateProgramRequest _$$_UpdateProgramRequestFromJson(Map json) =>
    _$_UpdateProgramRequest(
      apiKey: json['api_key'] as String,
      programId: json['program_id'] as String,
      programName: json['program_name'] as String,
      frequency:
          (json['frequency'] as List<dynamic>).map((e) => e as int).toList(),
      runsToCreate: (json['runs_to_create'] as List<dynamic>)
          .map((e) => RunCreation.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      runsToUpdate: (json['runs_to_update'] as List<dynamic>)
          .map((e) => Run.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$$_UpdateProgramRequestToJson(
        _$_UpdateProgramRequest instance) =>
    <String, dynamic>{
      'api_key': instance.apiKey,
      'program_id': instance.programId,
      'program_name': instance.programName,
      'frequency': instance.frequency,
      'runs_to_create': instance.runsToCreate.map((e) => e.toJson()).toList(),
      'runs_to_update': instance.runsToUpdate.map((e) => e.toJson()).toList(),
    };
