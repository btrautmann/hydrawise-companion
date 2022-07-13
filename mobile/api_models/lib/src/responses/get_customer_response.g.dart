// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_customer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GetCustomerResponse _$$_GetCustomerResponseFromJson(Map json) =>
    _$_GetCustomerResponse(
      customer:
          Customer.fromJson(Map<String, dynamic>.from(json['customer'] as Map)),
      zones: (json['zones'] as List<dynamic>)
          .map((e) => Zone.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$$_GetCustomerResponseToJson(
        _$_GetCustomerResponse instance) =>
    <String, dynamic>{
      'customer': instance.customer.toJson(),
      'zones': instance.zones.map((e) => e.toJson()).toList(),
    };
