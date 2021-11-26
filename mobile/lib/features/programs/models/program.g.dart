// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Program _$_$_ProgramFromJson(Map json) {
  return _$_Program(
    id: json['id'] as String,
    name: json['name'] as String,
    frequency:
        (json['frequency'] as List<dynamic>).map((e) => e as int).toList(),
  );
}

Map<String, dynamic> _$_$_ProgramToJson(_$_Program instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'frequency': instance.frequency,
    };
