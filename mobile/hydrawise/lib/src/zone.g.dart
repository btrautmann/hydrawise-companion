// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_HZone _$$_HZoneFromJson(Map json) => _$_HZone(
      id: json['relay_id'] as int,
      physicalNumber: json['relay'] as int,
      name: json['name'] as String,
      nextTimeOfWaterFriendly: json['timestr'] as String,
      secondsUntilNextRun: json['time'] as int,
      lengthOfNextRunTimeOrTimeRemaining: json['run'] as int,
    );

Map<String, dynamic> _$$_HZoneToJson(_$_HZone instance) => <String, dynamic>{
      'relay_id': instance.id,
      'relay': instance.physicalNumber,
      'name': instance.name,
      'timestr': instance.nextTimeOfWaterFriendly,
      'time': instance.secondsUntilNextRun,
      'run': instance.lengthOfNextRunTimeOrTimeRemaining,
    };
