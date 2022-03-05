// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Customer _$$_CustomerFromJson(Map json) => _$_Customer(
      activeControllerId: json['controller_id'] as int,
      customerId: json['customer_id'] as int,
      apiKey: json['api_key'] as String,
      lastStatusUpdate: json['last_status_update'] as int,
      timeZone: json['time_zone'] as String? ?? 'America/New_York',
    );

Map<String, dynamic> _$$_CustomerToJson(_$_Customer instance) =>
    <String, dynamic>{
      'controller_id': instance.activeControllerId,
      'customer_id': instance.customerId,
      'api_key': instance.apiKey,
      'last_status_update': instance.lastStatusUpdate,
      'time_zone': instance.timeZone,
    };
