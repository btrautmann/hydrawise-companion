// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Zone _$$_ZoneFromJson(Map json) => _$_Zone(
      id: json['id'] as int,
      number: json['zone_num'] as int,
      name: json['zone_name'] as String,
      timeUntilNextRunSec: json['time_until_run_sec'] as int,
      runLengthSec: json['run_length_sec'] as int,
    );

Map<String, dynamic> _$$_ZoneToJson(_$_Zone instance) => <String, dynamic>{
      'id': instance.id,
      'zone_num': instance.number,
      'zone_name': instance.name,
      'time_until_run_sec': instance.timeUntilNextRunSec,
      'run_length_sec': instance.runLengthSec,
    };
