// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Customer _$_$_CustomerFromJson(Map json) {
  return _$_Customer(
    activeControllerId: json['controller_id'] as int,
    customerId: json['customer_id'] as int,
    apiKey: json['api_key'] as String,
    lastStatusUpdate: json['last_status_update'] as int,
    timeZone: json['time_zone'] as String?,
  );
}

Map<String, dynamic> _$_$_CustomerToJson(_$_Customer instance) =>
    <String, dynamic>{
      'controller_id': instance.activeControllerId,
      'customer_id': instance.customerId,
      'api_key': instance.apiKey,
      'last_status_update': instance.lastStatusUpdate,
      'time_zone': instance.timeZone,
    };
