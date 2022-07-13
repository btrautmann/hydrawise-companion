// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_HCustomerStatus _$$_HCustomerStatusFromJson(Map json) => _$_HCustomerStatus(
      numberOfSecondsUntilNextRequest: json['nextpoll'] as int,
      timeOfLastStatusUnixEpoch: json['time'] as int,
      zones: (json['relays'] as List<dynamic>)
          .map((e) => HZone.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$$_HCustomerStatusToJson(_$_HCustomerStatus instance) =>
    <String, dynamic>{
      'nextpoll': instance.numberOfSecondsUntilNextRequest,
      'time': instance.timeOfLastStatusUnixEpoch,
      'relays': instance.zones.map((e) => e.toJson()).toList(),
    };
