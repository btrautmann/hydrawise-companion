// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_identification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CustomerIdentification _$_$_CustomerIdentificationFromJson(Map json) {
  return _$_CustomerIdentification(
    activeControllerId: json['controller_id'] as int,
    customerId: json['customer_id'] as int,
    apiKey: json['api_key'] as String,
    lastStatusUpdate: json['last_status_update'] as int,
  );
}

Map<String, dynamic> _$_$_CustomerIdentificationToJson(
        _$_CustomerIdentification instance) =>
    <String, dynamic>{
      'controller_id': instance.activeControllerId,
      'customer_id': instance.customerId,
      'api_key': instance.apiKey,
      'last_status_update': instance.lastStatusUpdate,
    };
