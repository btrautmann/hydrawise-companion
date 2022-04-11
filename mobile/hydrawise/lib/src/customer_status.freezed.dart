// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'customer_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CustomerStatus _$CustomerStatusFromJson(Map<String, dynamic> json) {
  return _CustomerStatus.fromJson(json);
}

/// @nodoc
class _$CustomerStatusTearOff {
  const _$CustomerStatusTearOff();

  _CustomerStatus call(
      {@JsonKey(name: 'nextpoll') required int numberOfSecondsUntilNextRequest,
      @JsonKey(name: 'time') required int timeOfLastStatusUnixEpoch,
      @JsonKey(name: 'relays') required List<Zone> zones}) {
    return _CustomerStatus(
      numberOfSecondsUntilNextRequest: numberOfSecondsUntilNextRequest,
      timeOfLastStatusUnixEpoch: timeOfLastStatusUnixEpoch,
      zones: zones,
    );
  }

  CustomerStatus fromJson(Map<String, Object?> json) {
    return CustomerStatus.fromJson(json);
  }
}

/// @nodoc
const $CustomerStatus = _$CustomerStatusTearOff();

/// @nodoc
mixin _$CustomerStatus {
  @JsonKey(name: 'nextpoll')
  int get numberOfSecondsUntilNextRequest => throw _privateConstructorUsedError;
  @JsonKey(name: 'time')
  int get timeOfLastStatusUnixEpoch => throw _privateConstructorUsedError;
  @JsonKey(name: 'relays')
  List<Zone> get zones => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomerStatusCopyWith<CustomerStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerStatusCopyWith<$Res> {
  factory $CustomerStatusCopyWith(
          CustomerStatus value, $Res Function(CustomerStatus) then) =
      _$CustomerStatusCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'nextpoll') int numberOfSecondsUntilNextRequest,
      @JsonKey(name: 'time') int timeOfLastStatusUnixEpoch,
      @JsonKey(name: 'relays') List<Zone> zones});
}

/// @nodoc
class _$CustomerStatusCopyWithImpl<$Res>
    implements $CustomerStatusCopyWith<$Res> {
  _$CustomerStatusCopyWithImpl(this._value, this._then);

  final CustomerStatus _value;
  // ignore: unused_field
  final $Res Function(CustomerStatus) _then;

  @override
  $Res call({
    Object? numberOfSecondsUntilNextRequest = freezed,
    Object? timeOfLastStatusUnixEpoch = freezed,
    Object? zones = freezed,
  }) {
    return _then(_value.copyWith(
      numberOfSecondsUntilNextRequest: numberOfSecondsUntilNextRequest ==
              freezed
          ? _value.numberOfSecondsUntilNextRequest
          : numberOfSecondsUntilNextRequest // ignore: cast_nullable_to_non_nullable
              as int,
      timeOfLastStatusUnixEpoch: timeOfLastStatusUnixEpoch == freezed
          ? _value.timeOfLastStatusUnixEpoch
          : timeOfLastStatusUnixEpoch // ignore: cast_nullable_to_non_nullable
              as int,
      zones: zones == freezed
          ? _value.zones
          : zones // ignore: cast_nullable_to_non_nullable
              as List<Zone>,
    ));
  }
}

/// @nodoc
abstract class _$CustomerStatusCopyWith<$Res>
    implements $CustomerStatusCopyWith<$Res> {
  factory _$CustomerStatusCopyWith(
          _CustomerStatus value, $Res Function(_CustomerStatus) then) =
      __$CustomerStatusCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'nextpoll') int numberOfSecondsUntilNextRequest,
      @JsonKey(name: 'time') int timeOfLastStatusUnixEpoch,
      @JsonKey(name: 'relays') List<Zone> zones});
}

/// @nodoc
class __$CustomerStatusCopyWithImpl<$Res>
    extends _$CustomerStatusCopyWithImpl<$Res>
    implements _$CustomerStatusCopyWith<$Res> {
  __$CustomerStatusCopyWithImpl(
      _CustomerStatus _value, $Res Function(_CustomerStatus) _then)
      : super(_value, (v) => _then(v as _CustomerStatus));

  @override
  _CustomerStatus get _value => super._value as _CustomerStatus;

  @override
  $Res call({
    Object? numberOfSecondsUntilNextRequest = freezed,
    Object? timeOfLastStatusUnixEpoch = freezed,
    Object? zones = freezed,
  }) {
    return _then(_CustomerStatus(
      numberOfSecondsUntilNextRequest: numberOfSecondsUntilNextRequest ==
              freezed
          ? _value.numberOfSecondsUntilNextRequest
          : numberOfSecondsUntilNextRequest // ignore: cast_nullable_to_non_nullable
              as int,
      timeOfLastStatusUnixEpoch: timeOfLastStatusUnixEpoch == freezed
          ? _value.timeOfLastStatusUnixEpoch
          : timeOfLastStatusUnixEpoch // ignore: cast_nullable_to_non_nullable
              as int,
      zones: zones == freezed
          ? _value.zones
          : zones // ignore: cast_nullable_to_non_nullable
              as List<Zone>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CustomerStatus implements _CustomerStatus {
  _$_CustomerStatus(
      {@JsonKey(name: 'nextpoll') required this.numberOfSecondsUntilNextRequest,
      @JsonKey(name: 'time') required this.timeOfLastStatusUnixEpoch,
      @JsonKey(name: 'relays') required this.zones});

  factory _$_CustomerStatus.fromJson(Map<String, dynamic> json) =>
      _$$_CustomerStatusFromJson(json);

  @override
  @JsonKey(name: 'nextpoll')
  final int numberOfSecondsUntilNextRequest;
  @override
  @JsonKey(name: 'time')
  final int timeOfLastStatusUnixEpoch;
  @override
  @JsonKey(name: 'relays')
  final List<Zone> zones;

  @override
  String toString() {
    return 'CustomerStatus(numberOfSecondsUntilNextRequest: $numberOfSecondsUntilNextRequest, timeOfLastStatusUnixEpoch: $timeOfLastStatusUnixEpoch, zones: $zones)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CustomerStatus &&
            const DeepCollectionEquality().equals(
                other.numberOfSecondsUntilNextRequest,
                numberOfSecondsUntilNextRequest) &&
            const DeepCollectionEquality().equals(
                other.timeOfLastStatusUnixEpoch, timeOfLastStatusUnixEpoch) &&
            const DeepCollectionEquality().equals(other.zones, zones));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(numberOfSecondsUntilNextRequest),
      const DeepCollectionEquality().hash(timeOfLastStatusUnixEpoch),
      const DeepCollectionEquality().hash(zones));

  @JsonKey(ignore: true)
  @override
  _$CustomerStatusCopyWith<_CustomerStatus> get copyWith =>
      __$CustomerStatusCopyWithImpl<_CustomerStatus>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CustomerStatusToJson(this);
  }
}

abstract class _CustomerStatus implements CustomerStatus {
  factory _CustomerStatus(
      {@JsonKey(name: 'nextpoll') required int numberOfSecondsUntilNextRequest,
      @JsonKey(name: 'time') required int timeOfLastStatusUnixEpoch,
      @JsonKey(name: 'relays') required List<Zone> zones}) = _$_CustomerStatus;

  factory _CustomerStatus.fromJson(Map<String, dynamic> json) =
      _$_CustomerStatus.fromJson;

  @override
  @JsonKey(name: 'nextpoll')
  int get numberOfSecondsUntilNextRequest;
  @override
  @JsonKey(name: 'time')
  int get timeOfLastStatusUnixEpoch;
  @override
  @JsonKey(name: 'relays')
  List<Zone> get zones;
  @override
  @JsonKey(ignore: true)
  _$CustomerStatusCopyWith<_CustomerStatus> get copyWith =>
      throw _privateConstructorUsedError;
}
