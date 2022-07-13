// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Customer _$$_CustomerFromJson(Map json) => _$_Customer(
      customerId: json['customer_id'] as int,
      apiKey: json['api_key'] as String,
      activeControllerId: json['active_controller_id'] as int,
    );

Map<String, dynamic> _$$_CustomerToJson(_$_Customer instance) =>
    <String, dynamic>{
      'customer_id': instance.customerId,
      'api_key': instance.apiKey,
      'active_controller_id': instance.activeControllerId,
    };
