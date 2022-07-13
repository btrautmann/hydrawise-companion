// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'stop_zone_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StopZoneRequest _$StopZoneRequestFromJson(Map<String, dynamic> json) {
  return _StopZoneRequest.fromJson(json);
}

/// @nodoc
mixin _$StopZoneRequest {
  @JsonKey(name: 'api_key')
  String get apiKey => throw _privateConstructorUsedError;
  @JsonKey(name: 'zone_id')
  int get zoneId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StopZoneRequestCopyWith<StopZoneRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StopZoneRequestCopyWith<$Res> {
  factory $StopZoneRequestCopyWith(
          StopZoneRequest value, $Res Function(StopZoneRequest) then) =
      _$StopZoneRequestCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'api_key') String apiKey,
      @JsonKey(name: 'zone_id') int zoneId});
}

/// @nodoc
class _$StopZoneRequestCopyWithImpl<$Res>
    implements $StopZoneRequestCopyWith<$Res> {
  _$StopZoneRequestCopyWithImpl(this._value, this._then);

  final StopZoneRequest _value;
  // ignore: unused_field
  final $Res Function(StopZoneRequest) _then;

  @override
  $Res call({
    Object? apiKey = freezed,
    Object? zoneId = freezed,
  }) {
    return _then(_value.copyWith(
      apiKey: apiKey == freezed
          ? _value.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String,
      zoneId: zoneId == freezed
          ? _value.zoneId
          : zoneId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_StopZoneRequestCopyWith<$Res>
    implements $StopZoneRequestCopyWith<$Res> {
  factory _$$_StopZoneRequestCopyWith(
          _$_StopZoneRequest value, $Res Function(_$_StopZoneRequest) then) =
      __$$_StopZoneRequestCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'api_key') String apiKey,
      @JsonKey(name: 'zone_id') int zoneId});
}

/// @nodoc
class __$$_StopZoneRequestCopyWithImpl<$Res>
    extends _$StopZoneRequestCopyWithImpl<$Res>
    implements _$$_StopZoneRequestCopyWith<$Res> {
  __$$_StopZoneRequestCopyWithImpl(
      _$_StopZoneRequest _value, $Res Function(_$_StopZoneRequest) _then)
      : super(_value, (v) => _then(v as _$_StopZoneRequest));

  @override
  _$_StopZoneRequest get _value => super._value as _$_StopZoneRequest;

  @override
  $Res call({
    Object? apiKey = freezed,
    Object? zoneId = freezed,
  }) {
    return _then(_$_StopZoneRequest(
      apiKey: apiKey == freezed
          ? _value.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String,
      zoneId: zoneId == freezed
          ? _value.zoneId
          : zoneId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_StopZoneRequest implements _StopZoneRequest {
  _$_StopZoneRequest(
      {@JsonKey(name: 'api_key') required this.apiKey,
      @JsonKey(name: 'zone_id') required this.zoneId});

  factory _$_StopZoneRequest.fromJson(Map<String, dynamic> json) =>
      _$$_StopZoneRequestFromJson(json);

  @override
  @JsonKey(name: 'api_key')
  final String apiKey;
  @override
  @JsonKey(name: 'zone_id')
  final int zoneId;

  @override
  String toString() {
    return 'StopZoneRequest(apiKey: $apiKey, zoneId: $zoneId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StopZoneRequest &&
            const DeepCollectionEquality().equals(other.apiKey, apiKey) &&
            const DeepCollectionEquality().equals(other.zoneId, zoneId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(apiKey),
      const DeepCollectionEquality().hash(zoneId));

  @JsonKey(ignore: true)
  @override
  _$$_StopZoneRequestCopyWith<_$_StopZoneRequest> get copyWith =>
      __$$_StopZoneRequestCopyWithImpl<_$_StopZoneRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StopZoneRequestToJson(this);
  }
}

abstract class _StopZoneRequest implements StopZoneRequest {
  factory _StopZoneRequest(
          {@JsonKey(name: 'api_key') required final String apiKey,
          @JsonKey(name: 'zone_id') required final int zoneId}) =
      _$_StopZoneRequest;

  factory _StopZoneRequest.fromJson(Map<String, dynamic> json) =
      _$_StopZoneRequest.fromJson;

  @override
  @JsonKey(name: 'api_key')
  String get apiKey;
  @override
  @JsonKey(name: 'zone_id')
  int get zoneId;
  @override
  @JsonKey(ignore: true)
  _$$_StopZoneRequestCopyWith<_$_StopZoneRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
