// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

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
      {@JsonKey(name: 'message') required String statusMessage,
      @JsonKey(name: 'nextpoll') required int numberOfSecondsUntilNextRequest,
      @JsonKey(name: 'time') required int timeOfLastStatusUnixEpoch,
      @JsonKey(name: 'relays') required List<Zone> zones,
      @JsonKey(name: 'master') int? masterZoneNumber,
      @JsonKey(name: 'master_timer') int? zoneDelay}) {
    return _CustomerStatus(
      statusMessage: statusMessage,
      numberOfSecondsUntilNextRequest: numberOfSecondsUntilNextRequest,
      timeOfLastStatusUnixEpoch: timeOfLastStatusUnixEpoch,
      zones: zones,
      masterZoneNumber: masterZoneNumber,
      zoneDelay: zoneDelay,
    );
  }

  CustomerStatus fromJson(Map<String, Object> json) {
    return CustomerStatus.fromJson(json);
  }
}

/// @nodoc
const $CustomerStatus = _$CustomerStatusTearOff();

/// @nodoc
mixin _$CustomerStatus {
  @JsonKey(name: 'message')
  String get statusMessage => throw _privateConstructorUsedError;
  @JsonKey(name: 'nextpoll')
  int get numberOfSecondsUntilNextRequest => throw _privateConstructorUsedError;
  @JsonKey(name: 'time')
  int get timeOfLastStatusUnixEpoch => throw _privateConstructorUsedError;
  @JsonKey(name: 'relays')
  List<Zone> get zones => throw _privateConstructorUsedError;
  @JsonKey(name: 'master')
  int? get masterZoneNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'master_timer')
  int? get zoneDelay => throw _privateConstructorUsedError;

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
      {@JsonKey(name: 'message') String statusMessage,
      @JsonKey(name: 'nextpoll') int numberOfSecondsUntilNextRequest,
      @JsonKey(name: 'time') int timeOfLastStatusUnixEpoch,
      @JsonKey(name: 'relays') List<Zone> zones,
      @JsonKey(name: 'master') int? masterZoneNumber,
      @JsonKey(name: 'master_timer') int? zoneDelay});
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
    Object? statusMessage = freezed,
    Object? numberOfSecondsUntilNextRequest = freezed,
    Object? timeOfLastStatusUnixEpoch = freezed,
    Object? zones = freezed,
    Object? masterZoneNumber = freezed,
    Object? zoneDelay = freezed,
  }) {
    return _then(_value.copyWith(
      statusMessage: statusMessage == freezed
          ? _value.statusMessage
          : statusMessage // ignore: cast_nullable_to_non_nullable
              as String,
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
      masterZoneNumber: masterZoneNumber == freezed
          ? _value.masterZoneNumber
          : masterZoneNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      zoneDelay: zoneDelay == freezed
          ? _value.zoneDelay
          : zoneDelay // ignore: cast_nullable_to_non_nullable
              as int?,
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
      {@JsonKey(name: 'message') String statusMessage,
      @JsonKey(name: 'nextpoll') int numberOfSecondsUntilNextRequest,
      @JsonKey(name: 'time') int timeOfLastStatusUnixEpoch,
      @JsonKey(name: 'relays') List<Zone> zones,
      @JsonKey(name: 'master') int? masterZoneNumber,
      @JsonKey(name: 'master_timer') int? zoneDelay});
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
    Object? statusMessage = freezed,
    Object? numberOfSecondsUntilNextRequest = freezed,
    Object? timeOfLastStatusUnixEpoch = freezed,
    Object? zones = freezed,
    Object? masterZoneNumber = freezed,
    Object? zoneDelay = freezed,
  }) {
    return _then(_CustomerStatus(
      statusMessage: statusMessage == freezed
          ? _value.statusMessage
          : statusMessage // ignore: cast_nullable_to_non_nullable
              as String,
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
      masterZoneNumber: masterZoneNumber == freezed
          ? _value.masterZoneNumber
          : masterZoneNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      zoneDelay: zoneDelay == freezed
          ? _value.zoneDelay
          : zoneDelay // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CustomerStatus implements _CustomerStatus {
  _$_CustomerStatus(
      {@JsonKey(name: 'message') required this.statusMessage,
      @JsonKey(name: 'nextpoll') required this.numberOfSecondsUntilNextRequest,
      @JsonKey(name: 'time') required this.timeOfLastStatusUnixEpoch,
      @JsonKey(name: 'relays') required this.zones,
      @JsonKey(name: 'master') this.masterZoneNumber,
      @JsonKey(name: 'master_timer') this.zoneDelay});

  factory _$_CustomerStatus.fromJson(Map<String, dynamic> json) =>
      _$_$_CustomerStatusFromJson(json);

  @override
  @JsonKey(name: 'message')
  final String statusMessage;
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
  @JsonKey(name: 'master')
  final int? masterZoneNumber;
  @override
  @JsonKey(name: 'master_timer')
  final int? zoneDelay;

  @override
  String toString() {
    return 'CustomerStatus(statusMessage: $statusMessage, numberOfSecondsUntilNextRequest: $numberOfSecondsUntilNextRequest, timeOfLastStatusUnixEpoch: $timeOfLastStatusUnixEpoch, zones: $zones, masterZoneNumber: $masterZoneNumber, zoneDelay: $zoneDelay)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CustomerStatus &&
            (identical(other.statusMessage, statusMessage) ||
                const DeepCollectionEquality()
                    .equals(other.statusMessage, statusMessage)) &&
            (identical(other.numberOfSecondsUntilNextRequest,
                    numberOfSecondsUntilNextRequest) ||
                const DeepCollectionEquality().equals(
                    other.numberOfSecondsUntilNextRequest,
                    numberOfSecondsUntilNextRequest)) &&
            (identical(other.timeOfLastStatusUnixEpoch,
                    timeOfLastStatusUnixEpoch) ||
                const DeepCollectionEquality().equals(
                    other.timeOfLastStatusUnixEpoch,
                    timeOfLastStatusUnixEpoch)) &&
            (identical(other.zones, zones) ||
                const DeepCollectionEquality().equals(other.zones, zones)) &&
            (identical(other.masterZoneNumber, masterZoneNumber) ||
                const DeepCollectionEquality()
                    .equals(other.masterZoneNumber, masterZoneNumber)) &&
            (identical(other.zoneDelay, zoneDelay) ||
                const DeepCollectionEquality()
                    .equals(other.zoneDelay, zoneDelay)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(statusMessage) ^
      const DeepCollectionEquality().hash(numberOfSecondsUntilNextRequest) ^
      const DeepCollectionEquality().hash(timeOfLastStatusUnixEpoch) ^
      const DeepCollectionEquality().hash(zones) ^
      const DeepCollectionEquality().hash(masterZoneNumber) ^
      const DeepCollectionEquality().hash(zoneDelay);

  @JsonKey(ignore: true)
  @override
  _$CustomerStatusCopyWith<_CustomerStatus> get copyWith =>
      __$CustomerStatusCopyWithImpl<_CustomerStatus>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CustomerStatusToJson(this);
  }
}

abstract class _CustomerStatus implements CustomerStatus {
  factory _CustomerStatus(
      {@JsonKey(name: 'message') required String statusMessage,
      @JsonKey(name: 'nextpoll') required int numberOfSecondsUntilNextRequest,
      @JsonKey(name: 'time') required int timeOfLastStatusUnixEpoch,
      @JsonKey(name: 'relays') required List<Zone> zones,
      @JsonKey(name: 'master') int? masterZoneNumber,
      @JsonKey(name: 'master_timer') int? zoneDelay}) = _$_CustomerStatus;

  factory _CustomerStatus.fromJson(Map<String, dynamic> json) =
      _$_CustomerStatus.fromJson;

  @override
  @JsonKey(name: 'message')
  String get statusMessage => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'nextpoll')
  int get numberOfSecondsUntilNextRequest => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'time')
  int get timeOfLastStatusUnixEpoch => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'relays')
  List<Zone> get zones => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'master')
  int? get masterZoneNumber => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'master_timer')
  int? get zoneDelay => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CustomerStatusCopyWith<_CustomerStatus> get copyWith =>
      throw _privateConstructorUsedError;
}
