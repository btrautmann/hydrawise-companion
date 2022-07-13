// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'run_zone_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RunZoneRequest _$RunZoneRequestFromJson(Map<String, dynamic> json) {
  return _RunZoneRequest.fromJson(json);
}

/// @nodoc
mixin _$RunZoneRequest {
  @JsonKey(name: 'api_key')
  String get apiKey => throw _privateConstructorUsedError;
  @JsonKey(name: 'zone_id')
  int get zoneId => throw _privateConstructorUsedError;
  @JsonKey(name: 'run_length_seconds')
  int get runLengthSeconds => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RunZoneRequestCopyWith<RunZoneRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RunZoneRequestCopyWith<$Res> {
  factory $RunZoneRequestCopyWith(
          RunZoneRequest value, $Res Function(RunZoneRequest) then) =
      _$RunZoneRequestCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'api_key') String apiKey,
      @JsonKey(name: 'zone_id') int zoneId,
      @JsonKey(name: 'run_length_seconds') int runLengthSeconds});
}

/// @nodoc
class _$RunZoneRequestCopyWithImpl<$Res>
    implements $RunZoneRequestCopyWith<$Res> {
  _$RunZoneRequestCopyWithImpl(this._value, this._then);

  final RunZoneRequest _value;
  // ignore: unused_field
  final $Res Function(RunZoneRequest) _then;

  @override
  $Res call({
    Object? apiKey = freezed,
    Object? zoneId = freezed,
    Object? runLengthSeconds = freezed,
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
      runLengthSeconds: runLengthSeconds == freezed
          ? _value.runLengthSeconds
          : runLengthSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_RunZoneRequestCopyWith<$Res>
    implements $RunZoneRequestCopyWith<$Res> {
  factory _$$_RunZoneRequestCopyWith(
          _$_RunZoneRequest value, $Res Function(_$_RunZoneRequest) then) =
      __$$_RunZoneRequestCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'api_key') String apiKey,
      @JsonKey(name: 'zone_id') int zoneId,
      @JsonKey(name: 'run_length_seconds') int runLengthSeconds});
}

/// @nodoc
class __$$_RunZoneRequestCopyWithImpl<$Res>
    extends _$RunZoneRequestCopyWithImpl<$Res>
    implements _$$_RunZoneRequestCopyWith<$Res> {
  __$$_RunZoneRequestCopyWithImpl(
      _$_RunZoneRequest _value, $Res Function(_$_RunZoneRequest) _then)
      : super(_value, (v) => _then(v as _$_RunZoneRequest));

  @override
  _$_RunZoneRequest get _value => super._value as _$_RunZoneRequest;

  @override
  $Res call({
    Object? apiKey = freezed,
    Object? zoneId = freezed,
    Object? runLengthSeconds = freezed,
  }) {
    return _then(_$_RunZoneRequest(
      apiKey: apiKey == freezed
          ? _value.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String,
      zoneId: zoneId == freezed
          ? _value.zoneId
          : zoneId // ignore: cast_nullable_to_non_nullable
              as int,
      runLengthSeconds: runLengthSeconds == freezed
          ? _value.runLengthSeconds
          : runLengthSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RunZoneRequest implements _RunZoneRequest {
  _$_RunZoneRequest(
      {@JsonKey(name: 'api_key') required this.apiKey,
      @JsonKey(name: 'zone_id') required this.zoneId,
      @JsonKey(name: 'run_length_seconds') required this.runLengthSeconds});

  factory _$_RunZoneRequest.fromJson(Map<String, dynamic> json) =>
      _$$_RunZoneRequestFromJson(json);

  @override
  @JsonKey(name: 'api_key')
  final String apiKey;
  @override
  @JsonKey(name: 'zone_id')
  final int zoneId;
  @override
  @JsonKey(name: 'run_length_seconds')
  final int runLengthSeconds;

  @override
  String toString() {
    return 'RunZoneRequest(apiKey: $apiKey, zoneId: $zoneId, runLengthSeconds: $runLengthSeconds)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RunZoneRequest &&
            const DeepCollectionEquality().equals(other.apiKey, apiKey) &&
            const DeepCollectionEquality().equals(other.zoneId, zoneId) &&
            const DeepCollectionEquality()
                .equals(other.runLengthSeconds, runLengthSeconds));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(apiKey),
      const DeepCollectionEquality().hash(zoneId),
      const DeepCollectionEquality().hash(runLengthSeconds));

  @JsonKey(ignore: true)
  @override
  _$$_RunZoneRequestCopyWith<_$_RunZoneRequest> get copyWith =>
      __$$_RunZoneRequestCopyWithImpl<_$_RunZoneRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RunZoneRequestToJson(this);
  }
}

abstract class _RunZoneRequest implements RunZoneRequest {
  factory _RunZoneRequest(
      {@JsonKey(name: 'api_key')
          required final String apiKey,
      @JsonKey(name: 'zone_id')
          required final int zoneId,
      @JsonKey(name: 'run_length_seconds')
          required final int runLengthSeconds}) = _$_RunZoneRequest;

  factory _RunZoneRequest.fromJson(Map<String, dynamic> json) =
      _$_RunZoneRequest.fromJson;

  @override
  @JsonKey(name: 'api_key')
  String get apiKey;
  @override
  @JsonKey(name: 'zone_id')
  int get zoneId;
  @override
  @JsonKey(name: 'run_length_seconds')
  int get runLengthSeconds;
  @override
  @JsonKey(ignore: true)
  _$$_RunZoneRequestCopyWith<_$_RunZoneRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
