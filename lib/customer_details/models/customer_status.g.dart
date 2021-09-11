// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CustomerStatus _$_$_CustomerStatusFromJson(Map json) {
  return _$_CustomerStatus(
    statusMessage: json['message'] as String,
    numberOfSecondsUntilNextRequest: json['nextpoll'] as int,
    timeOfLastStatusUnixEpoch: json['time'] as int,
    zones: (json['relays'] as List<dynamic>)
        .map((e) => Zone.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList(),
    masterZoneNumber: json['master'] as int?,
    zoneDelay: json['master_timer'] as int?,
  );
}

Map<String, dynamic> _$_$_CustomerStatusToJson(_$_CustomerStatus instance) =>
    <String, dynamic>{
      'message': instance.statusMessage,
      'nextpoll': instance.numberOfSecondsUntilNextRequest,
      'time': instance.timeOfLastStatusUnixEpoch,
      'relays': instance.zones.map((e) => e.toJson()).toList(),
      'master': instance.masterZoneNumber,
      'master_timer': instance.zoneDelay,
    };
