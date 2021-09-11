// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CustomerDetails _$_$_CustomerDetailsFromJson(Map json) {
  return _$_CustomerDetails(
    activeControllerId: json['controller_id'] as int,
    customerId: json['customer_id'] as int,
    controllers: (json['controllers'] as List<dynamic>)
        .map((e) => Controller.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList(),
  );
}

Map<String, dynamic> _$_$_CustomerDetailsToJson(_$_CustomerDetails instance) =>
    <String, dynamic>{
      'controller_id': instance.activeControllerId,
      'customer_id': instance.customerId,
      'controllers': instance.controllers.map((e) => e.toJson()).toList(),
    };
