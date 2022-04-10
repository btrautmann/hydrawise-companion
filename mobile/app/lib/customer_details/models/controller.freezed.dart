// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Controller _$ControllerFromJson(Map<String, dynamic> json) {
  return _Controller.fromJson(json);
}

/// @nodoc
class _$ControllerTearOff {
  const _$ControllerTearOff();

  _Controller call(
      {@JsonKey(name: 'name') required String name,
      @JsonKey(name: 'last_contact') required int lastContact,
      @JsonKey(name: 'serial_number') required String serialNumber,
      @JsonKey(name: 'controller_id') required int id,
      @JsonKey(name: 'status') required String status}) {
    return _Controller(
      name: name,
      lastContact: lastContact,
      serialNumber: serialNumber,
      id: id,
      status: status,
    );
  }

  Controller fromJson(Map<String, Object?> json) {
    return Controller.fromJson(json);
  }
}

/// @nodoc
const $Controller = _$ControllerTearOff();

/// @nodoc
mixin _$Controller {
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_contact')
  int get lastContact => throw _privateConstructorUsedError;
  @JsonKey(name: 'serial_number')
  String get serialNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'controller_id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'status')
  String get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ControllerCopyWith<Controller> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ControllerCopyWith<$Res> {
  factory $ControllerCopyWith(
          Controller value, $Res Function(Controller) then) =
      _$ControllerCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'name') String name,
      @JsonKey(name: 'last_contact') int lastContact,
      @JsonKey(name: 'serial_number') String serialNumber,
      @JsonKey(name: 'controller_id') int id,
      @JsonKey(name: 'status') String status});
}

/// @nodoc
class _$ControllerCopyWithImpl<$Res> implements $ControllerCopyWith<$Res> {
  _$ControllerCopyWithImpl(this._value, this._then);

  final Controller _value;
  // ignore: unused_field
  final $Res Function(Controller) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? lastContact = freezed,
    Object? serialNumber = freezed,
    Object? id = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      lastContact: lastContact == freezed
          ? _value.lastContact
          : lastContact // ignore: cast_nullable_to_non_nullable
              as int,
      serialNumber: serialNumber == freezed
          ? _value.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$ControllerCopyWith<$Res> implements $ControllerCopyWith<$Res> {
  factory _$ControllerCopyWith(
          _Controller value, $Res Function(_Controller) then) =
      __$ControllerCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'name') String name,
      @JsonKey(name: 'last_contact') int lastContact,
      @JsonKey(name: 'serial_number') String serialNumber,
      @JsonKey(name: 'controller_id') int id,
      @JsonKey(name: 'status') String status});
}

/// @nodoc
class __$ControllerCopyWithImpl<$Res> extends _$ControllerCopyWithImpl<$Res>
    implements _$ControllerCopyWith<$Res> {
  __$ControllerCopyWithImpl(
      _Controller _value, $Res Function(_Controller) _then)
      : super(_value, (v) => _then(v as _Controller));

  @override
  _Controller get _value => super._value as _Controller;

  @override
  $Res call({
    Object? name = freezed,
    Object? lastContact = freezed,
    Object? serialNumber = freezed,
    Object? id = freezed,
    Object? status = freezed,
  }) {
    return _then(_Controller(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      lastContact: lastContact == freezed
          ? _value.lastContact
          : lastContact // ignore: cast_nullable_to_non_nullable
              as int,
      serialNumber: serialNumber == freezed
          ? _value.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Controller implements _Controller {
  _$_Controller(
      {@JsonKey(name: 'name') required this.name,
      @JsonKey(name: 'last_contact') required this.lastContact,
      @JsonKey(name: 'serial_number') required this.serialNumber,
      @JsonKey(name: 'controller_id') required this.id,
      @JsonKey(name: 'status') required this.status});

  factory _$_Controller.fromJson(Map<String, dynamic> json) =>
      _$$_ControllerFromJson(json);

  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'last_contact')
  final int lastContact;
  @override
  @JsonKey(name: 'serial_number')
  final String serialNumber;
  @override
  @JsonKey(name: 'controller_id')
  final int id;
  @override
  @JsonKey(name: 'status')
  final String status;

  @override
  String toString() {
    return 'Controller(name: $name, lastContact: $lastContact, serialNumber: $serialNumber, id: $id, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Controller &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.lastContact, lastContact) &&
            const DeepCollectionEquality()
                .equals(other.serialNumber, serialNumber) &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.status, status));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(lastContact),
      const DeepCollectionEquality().hash(serialNumber),
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(status));

  @JsonKey(ignore: true)
  @override
  _$ControllerCopyWith<_Controller> get copyWith =>
      __$ControllerCopyWithImpl<_Controller>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ControllerToJson(this);
  }
}

abstract class _Controller implements Controller {
  factory _Controller(
      {@JsonKey(name: 'name') required String name,
      @JsonKey(name: 'last_contact') required int lastContact,
      @JsonKey(name: 'serial_number') required String serialNumber,
      @JsonKey(name: 'controller_id') required int id,
      @JsonKey(name: 'status') required String status}) = _$_Controller;

  factory _Controller.fromJson(Map<String, dynamic> json) =
      _$_Controller.fromJson;

  @override
  @JsonKey(name: 'name')
  String get name;
  @override
  @JsonKey(name: 'last_contact')
  int get lastContact;
  @override
  @JsonKey(name: 'serial_number')
  String get serialNumber;
  @override
  @JsonKey(name: 'controller_id')
  int get id;
  @override
  @JsonKey(name: 'status')
  String get status;
  @override
  @JsonKey(ignore: true)
  _$ControllerCopyWith<_Controller> get copyWith =>
      throw _privateConstructorUsedError;
}
