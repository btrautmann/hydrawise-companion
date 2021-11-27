// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Zone _$_$_ZoneFromJson(Map json) {
  return _$_Zone(
    id: json['relay_id'] as int,
    physicalNumber: json['relay'] as int,
    name: json['name'] as String,
    nextTimeOfWaterFriendly: json['timestr'] as String,
    secondsUntilNextRun: json['time'] as int,
    lengthOfNextRunTimeOrTimeRemaining: json['run'] as int,
  );
}

Map<String, dynamic> _$_$_ZoneToJson(_$_Zone instance) => <String, dynamic>{
      'relay_id': instance.id,
      'relay': instance.physicalNumber,
      'name': instance.name,
      'timestr': instance.nextTimeOfWaterFriendly,
      'time': instance.secondsUntilNextRun,
      'run': instance.lengthOfNextRunTimeOrTimeRemaining,
    };
