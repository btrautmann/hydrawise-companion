// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Controller _$_$_ControllerFromJson(Map json) {
  return _$_Controller(
    name: json['name'] as String,
    lastContact: json['last_contact'] as int,
    serialNumber: json['serial_number'] as String,
    id: json['controller_id'] as int,
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$_$_ControllerToJson(_$_Controller instance) =>
    <String, dynamic>{
      'name': instance.name,
      'last_contact': instance.lastContact,
      'serial_number': instance.serialNumber,
      'controller_id': instance.id,
      'status': instance.status,
    };
