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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

HCustomerStatus _$HCustomerStatusFromJson(Map<String, dynamic> json) {
  return _HCustomerStatus.fromJson(json);
}

/// @nodoc
mixin _$HCustomerStatus {
  @JsonKey(name: 'nextpoll')
  int get numberOfSecondsUntilNextRequest => throw _privateConstructorUsedError;
  @JsonKey(name: 'time')
  int get timeOfLastStatusUnixEpoch => throw _privateConstructorUsedError;
  @JsonKey(name: 'relays')
  List<HZone> get zones => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HCustomerStatusCopyWith<HCustomerStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HCustomerStatusCopyWith<$Res> {
  factory $HCustomerStatusCopyWith(
          HCustomerStatus value, $Res Function(HCustomerStatus) then) =
      _$HCustomerStatusCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'nextpoll') int numberOfSecondsUntilNextRequest,
      @JsonKey(name: 'time') int timeOfLastStatusUnixEpoch,
      @JsonKey(name: 'relays') List<HZone> zones});
}

/// @nodoc
class _$HCustomerStatusCopyWithImpl<$Res>
    implements $HCustomerStatusCopyWith<$Res> {
  _$HCustomerStatusCopyWithImpl(this._value, this._then);

  final HCustomerStatus _value;
  // ignore: unused_field
  final $Res Function(HCustomerStatus) _then;

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
              as List<HZone>,
    ));
  }
}

/// @nodoc
abstract class _$$_HCustomerStatusCopyWith<$Res>
    implements $HCustomerStatusCopyWith<$Res> {
  factory _$$_HCustomerStatusCopyWith(
          _$_HCustomerStatus value, $Res Function(_$_HCustomerStatus) then) =
      __$$_HCustomerStatusCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'nextpoll') int numberOfSecondsUntilNextRequest,
      @JsonKey(name: 'time') int timeOfLastStatusUnixEpoch,
      @JsonKey(name: 'relays') List<HZone> zones});
}

/// @nodoc
class __$$_HCustomerStatusCopyWithImpl<$Res>
    extends _$HCustomerStatusCopyWithImpl<$Res>
    implements _$$_HCustomerStatusCopyWith<$Res> {
  __$$_HCustomerStatusCopyWithImpl(
      _$_HCustomerStatus _value, $Res Function(_$_HCustomerStatus) _then)
      : super(_value, (v) => _then(v as _$_HCustomerStatus));

  @override
  _$_HCustomerStatus get _value => super._value as _$_HCustomerStatus;

  @override
  $Res call({
    Object? numberOfSecondsUntilNextRequest = freezed,
    Object? timeOfLastStatusUnixEpoch = freezed,
    Object? zones = freezed,
  }) {
    return _then(_$_HCustomerStatus(
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
          ? _value._zones
          : zones // ignore: cast_nullable_to_non_nullable
              as List<HZone>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_HCustomerStatus implements _HCustomerStatus {
  _$_HCustomerStatus(
      {@JsonKey(name: 'nextpoll') required this.numberOfSecondsUntilNextRequest,
      @JsonKey(name: 'time') required this.timeOfLastStatusUnixEpoch,
      @JsonKey(name: 'relays') required final List<HZone> zones})
      : _zones = zones;

  factory _$_HCustomerStatus.fromJson(Map<String, dynamic> json) =>
      _$$_HCustomerStatusFromJson(json);

  @override
  @JsonKey(name: 'nextpoll')
  final int numberOfSecondsUntilNextRequest;
  @override
  @JsonKey(name: 'time')
  final int timeOfLastStatusUnixEpoch;
  final List<HZone> _zones;
  @override
  @JsonKey(name: 'relays')
  List<HZone> get zones {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_zones);
  }

  @override
  String toString() {
    return 'HCustomerStatus(numberOfSecondsUntilNextRequest: $numberOfSecondsUntilNextRequest, timeOfLastStatusUnixEpoch: $timeOfLastStatusUnixEpoch, zones: $zones)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HCustomerStatus &&
            const DeepCollectionEquality().equals(
                other.numberOfSecondsUntilNextRequest,
                numberOfSecondsUntilNextRequest) &&
            const DeepCollectionEquality().equals(
                other.timeOfLastStatusUnixEpoch, timeOfLastStatusUnixEpoch) &&
            const DeepCollectionEquality().equals(other._zones, _zones));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(numberOfSecondsUntilNextRequest),
      const DeepCollectionEquality().hash(timeOfLastStatusUnixEpoch),
      const DeepCollectionEquality().hash(_zones));

  @JsonKey(ignore: true)
  @override
  _$$_HCustomerStatusCopyWith<_$_HCustomerStatus> get copyWith =>
      __$$_HCustomerStatusCopyWithImpl<_$_HCustomerStatus>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HCustomerStatusToJson(this);
  }
}

abstract class _HCustomerStatus implements HCustomerStatus {
  factory _HCustomerStatus(
      {@JsonKey(name: 'nextpoll')
          required final int numberOfSecondsUntilNextRequest,
      @JsonKey(name: 'time')
          required final int timeOfLastStatusUnixEpoch,
      @JsonKey(name: 'relays')
          required final List<HZone> zones}) = _$_HCustomerStatus;

  factory _HCustomerStatus.fromJson(Map<String, dynamic> json) =
      _$_HCustomerStatus.fromJson;

  @override
  @JsonKey(name: 'nextpoll')
  int get numberOfSecondsUntilNextRequest;
  @override
  @JsonKey(name: 'time')
  int get timeOfLastStatusUnixEpoch;
  @override
  @JsonKey(name: 'relays')
  List<HZone> get zones;
  @override
  @JsonKey(ignore: true)
  _$$_HCustomerStatusCopyWith<_$_HCustomerStatus> get copyWith =>
      throw _privateConstructorUsedError;
}
