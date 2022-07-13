// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_HCustomerDetails _$$_HCustomerDetailsFromJson(Map json) =>
    _$_HCustomerDetails(
      activeControllerId: json['controller_id'] as int,
      customerId: json['customer_id'] as int,
      controllers: (json['controllers'] as List<dynamic>)
          .map((e) =>
              HydrawiseController.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$$_HCustomerDetailsToJson(_$_HCustomerDetails instance) =>
    <String, dynamic>{
      'controller_id': instance.activeControllerId,
      'customer_id': instance.customerId,
      'controllers': instance.controllers.map((e) => e.toJson()).toList(),
    };
