// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LoginResponse _$$_LoginResponseFromJson(Map json) => _$_LoginResponse(
      customer:
          Customer.fromJson(Map<String, dynamic>.from(json['customer'] as Map)),
    );

Map<String, dynamic> _$$_LoginResponseToJson(_$_LoginResponse instance) =>
    <String, dynamic>{
      'customer': instance.customer.toJson(),
    };
