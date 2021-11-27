// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'run.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Run _$_$_RunFromJson(Map json) {
  return _$_Run(
    id: json['id'] as String,
    programId: json['p_id'] as String,
    startTime: TimeOfDayX.fromJson(json['start_time'] as String),
    duration: json['duration'] as int,
    zoneId: json['z_id'] as int,
  );
}

Map<String, dynamic> _$_$_RunToJson(_$_Run instance) => <String, dynamic>{
      'id': instance.id,
      'p_id': instance.programId,
      'start_time': TimeOfDayX.toJson(instance.startTime),
      'duration': instance.duration,
      'z_id': instance.zoneId,
    };
