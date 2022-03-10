// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CustomerStatus _$$_CustomerStatusFromJson(Map json) => _$_CustomerStatus(
      numberOfSecondsUntilNextRequest: json['nextpoll'] as int,
      timeOfLastStatusUnixEpoch: json['time'] as int,
      zones: (json['relays'] as List<dynamic>)
          .map((e) => Zone.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$$_CustomerStatusToJson(_$_CustomerStatus instance) =>
    <String, dynamic>{
      'nextpoll': instance.numberOfSecondsUntilNextRequest,
      'time': instance.timeOfLastStatusUnixEpoch,
      'relays': instance.zones.map((e) => e.toJson()).toList(),
    };
