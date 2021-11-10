// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'run_creation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$RunCreationTearOff {
  const _$RunCreationTearOff();

  _RunCreation call(
      {TimeOfDay? timeOfDay, List<Zone>? zones, Duration? duration}) {
    return _RunCreation(
      timeOfDay: timeOfDay,
      zones: zones,
      duration: duration,
    );
  }
}

/// @nodoc
const $RunCreation = _$RunCreationTearOff();

/// @nodoc
mixin _$RunCreation {
  TimeOfDay? get timeOfDay => throw _privateConstructorUsedError;
  List<Zone>? get zones => throw _privateConstructorUsedError;
  Duration? get duration => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RunCreationCopyWith<RunCreation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RunCreationCopyWith<$Res> {
  factory $RunCreationCopyWith(
          RunCreation value, $Res Function(RunCreation) then) =
      _$RunCreationCopyWithImpl<$Res>;
  $Res call({TimeOfDay? timeOfDay, List<Zone>? zones, Duration? duration});
}

/// @nodoc
class _$RunCreationCopyWithImpl<$Res> implements $RunCreationCopyWith<$Res> {
  _$RunCreationCopyWithImpl(this._value, this._then);

  final RunCreation _value;
  // ignore: unused_field
  final $Res Function(RunCreation) _then;

  @override
  $Res call({
    Object? timeOfDay = freezed,
    Object? zones = freezed,
    Object? duration = freezed,
  }) {
    return _then(_value.copyWith(
      timeOfDay: timeOfDay == freezed
          ? _value.timeOfDay
          : timeOfDay // ignore: cast_nullable_to_non_nullable
              as TimeOfDay?,
      zones: zones == freezed
          ? _value.zones
          : zones // ignore: cast_nullable_to_non_nullable
              as List<Zone>?,
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration?,
    ));
  }
}

/// @nodoc
abstract class _$RunCreationCopyWith<$Res>
    implements $RunCreationCopyWith<$Res> {
  factory _$RunCreationCopyWith(
          _RunCreation value, $Res Function(_RunCreation) then) =
      __$RunCreationCopyWithImpl<$Res>;
  @override
  $Res call({TimeOfDay? timeOfDay, List<Zone>? zones, Duration? duration});
}

/// @nodoc
class __$RunCreationCopyWithImpl<$Res> extends _$RunCreationCopyWithImpl<$Res>
    implements _$RunCreationCopyWith<$Res> {
  __$RunCreationCopyWithImpl(
      _RunCreation _value, $Res Function(_RunCreation) _then)
      : super(_value, (v) => _then(v as _RunCreation));

  @override
  _RunCreation get _value => super._value as _RunCreation;

  @override
  $Res call({
    Object? timeOfDay = freezed,
    Object? zones = freezed,
    Object? duration = freezed,
  }) {
    return _then(_RunCreation(
      timeOfDay: timeOfDay == freezed
          ? _value.timeOfDay
          : timeOfDay // ignore: cast_nullable_to_non_nullable
              as TimeOfDay?,
      zones: zones == freezed
          ? _value.zones
          : zones // ignore: cast_nullable_to_non_nullable
              as List<Zone>?,
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration?,
    ));
  }
}

/// @nodoc

class _$_RunCreation implements _RunCreation {
  _$_RunCreation({this.timeOfDay, this.zones, this.duration});

  @override
  final TimeOfDay? timeOfDay;
  @override
  final List<Zone>? zones;
  @override
  final Duration? duration;

  @override
  String toString() {
    return 'RunCreation(timeOfDay: $timeOfDay, zones: $zones, duration: $duration)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RunCreation &&
            (identical(other.timeOfDay, timeOfDay) ||
                const DeepCollectionEquality()
                    .equals(other.timeOfDay, timeOfDay)) &&
            (identical(other.zones, zones) ||
                const DeepCollectionEquality().equals(other.zones, zones)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality()
                    .equals(other.duration, duration)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(timeOfDay) ^
      const DeepCollectionEquality().hash(zones) ^
      const DeepCollectionEquality().hash(duration);

  @JsonKey(ignore: true)
  @override
  _$RunCreationCopyWith<_RunCreation> get copyWith =>
      __$RunCreationCopyWithImpl<_RunCreation>(this, _$identity);
}

abstract class _RunCreation implements RunCreation {
  factory _RunCreation(
      {TimeOfDay? timeOfDay,
      List<Zone>? zones,
      Duration? duration}) = _$_RunCreation;

  @override
  TimeOfDay? get timeOfDay => throw _privateConstructorUsedError;
  @override
  List<Zone>? get zones => throw _privateConstructorUsedError;
  @override
  Duration? get duration => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$RunCreationCopyWith<_RunCreation> get copyWith =>
      throw _privateConstructorUsedError;
}
