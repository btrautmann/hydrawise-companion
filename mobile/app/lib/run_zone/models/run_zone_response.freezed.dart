// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'run_zone_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RunZoneResponse _$RunZoneResponseFromJson(Map<String, dynamic> json) {
  return _RunZoneResponse.fromJson(json);
}

/// @nodoc
mixin _$RunZoneResponse {
  @JsonKey(name: 'message')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'message_type')
  String get typeOfMessage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RunZoneResponseCopyWith<RunZoneResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RunZoneResponseCopyWith<$Res> {
  factory $RunZoneResponseCopyWith(
          RunZoneResponse value, $Res Function(RunZoneResponse) then) =
      _$RunZoneResponseCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'message') String message,
      @JsonKey(name: 'message_type') String typeOfMessage});
}

/// @nodoc
class _$RunZoneResponseCopyWithImpl<$Res>
    implements $RunZoneResponseCopyWith<$Res> {
  _$RunZoneResponseCopyWithImpl(this._value, this._then);

  final RunZoneResponse _value;
  // ignore: unused_field
  final $Res Function(RunZoneResponse) _then;

  @override
  $Res call({
    Object? message = freezed,
    Object? typeOfMessage = freezed,
  }) {
    return _then(_value.copyWith(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      typeOfMessage: typeOfMessage == freezed
          ? _value.typeOfMessage
          : typeOfMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_RunZoneResponseCopyWith<$Res>
    implements $RunZoneResponseCopyWith<$Res> {
  factory _$$_RunZoneResponseCopyWith(
          _$_RunZoneResponse value, $Res Function(_$_RunZoneResponse) then) =
      __$$_RunZoneResponseCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'message') String message,
      @JsonKey(name: 'message_type') String typeOfMessage});
}

/// @nodoc
class __$$_RunZoneResponseCopyWithImpl<$Res>
    extends _$RunZoneResponseCopyWithImpl<$Res>
    implements _$$_RunZoneResponseCopyWith<$Res> {
  __$$_RunZoneResponseCopyWithImpl(
      _$_RunZoneResponse _value, $Res Function(_$_RunZoneResponse) _then)
      : super(_value, (v) => _then(v as _$_RunZoneResponse));

  @override
  _$_RunZoneResponse get _value => super._value as _$_RunZoneResponse;

  @override
  $Res call({
    Object? message = freezed,
    Object? typeOfMessage = freezed,
  }) {
    return _then(_$_RunZoneResponse(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      typeOfMessage: typeOfMessage == freezed
          ? _value.typeOfMessage
          : typeOfMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RunZoneResponse implements _RunZoneResponse {
  _$_RunZoneResponse(
      {@JsonKey(name: 'message') required this.message,
      @JsonKey(name: 'message_type') required this.typeOfMessage});

  factory _$_RunZoneResponse.fromJson(Map<String, dynamic> json) =>
      _$$_RunZoneResponseFromJson(json);

  @override
  @JsonKey(name: 'message')
  final String message;
  @override
  @JsonKey(name: 'message_type')
  final String typeOfMessage;

  @override
  String toString() {
    return 'RunZoneResponse(message: $message, typeOfMessage: $typeOfMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RunZoneResponse &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality()
                .equals(other.typeOfMessage, typeOfMessage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(typeOfMessage));

  @JsonKey(ignore: true)
  @override
  _$$_RunZoneResponseCopyWith<_$_RunZoneResponse> get copyWith =>
      __$$_RunZoneResponseCopyWithImpl<_$_RunZoneResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RunZoneResponseToJson(this);
  }
}

abstract class _RunZoneResponse implements RunZoneResponse {
  factory _RunZoneResponse(
          {@JsonKey(name: 'message') required final String message,
          @JsonKey(name: 'message_type') required final String typeOfMessage}) =
      _$_RunZoneResponse;

  factory _RunZoneResponse.fromJson(Map<String, dynamic> json) =
      _$_RunZoneResponse.fromJson;

  @override
  @JsonKey(name: 'message')
  String get message;
  @override
  @JsonKey(name: 'message_type')
  String get typeOfMessage;
  @override
  @JsonKey(ignore: true)
  _$$_RunZoneResponseCopyWith<_$_RunZoneResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
