// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'run_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RunGroup {
  RunGroupType get type => throw _privateConstructorUsedError;
  TimeOfDay get timeOfDay => throw _privateConstructorUsedError;
  List<int> get zoneIds => throw _privateConstructorUsedError;
  Duration get duration => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RunGroupCopyWith<RunGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RunGroupCopyWith<$Res> {
  factory $RunGroupCopyWith(RunGroup value, $Res Function(RunGroup) then) =
      _$RunGroupCopyWithImpl<$Res>;
  $Res call(
      {RunGroupType type,
      TimeOfDay timeOfDay,
      List<int> zoneIds,
      Duration duration});
}

/// @nodoc
class _$RunGroupCopyWithImpl<$Res> implements $RunGroupCopyWith<$Res> {
  _$RunGroupCopyWithImpl(this._value, this._then);

  final RunGroup _value;
  // ignore: unused_field
  final $Res Function(RunGroup) _then;

  @override
  $Res call({
    Object? type = freezed,
    Object? timeOfDay = freezed,
    Object? zoneIds = freezed,
    Object? duration = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as RunGroupType,
      timeOfDay: timeOfDay == freezed
          ? _value.timeOfDay
          : timeOfDay // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      zoneIds: zoneIds == freezed
          ? _value.zoneIds
          : zoneIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc
abstract class _$$_RunGroupCopyWith<$Res> implements $RunGroupCopyWith<$Res> {
  factory _$$_RunGroupCopyWith(
          _$_RunGroup value, $Res Function(_$_RunGroup) then) =
      __$$_RunGroupCopyWithImpl<$Res>;
  @override
  $Res call(
      {RunGroupType type,
      TimeOfDay timeOfDay,
      List<int> zoneIds,
      Duration duration});
}

/// @nodoc
class __$$_RunGroupCopyWithImpl<$Res> extends _$RunGroupCopyWithImpl<$Res>
    implements _$$_RunGroupCopyWith<$Res> {
  __$$_RunGroupCopyWithImpl(
      _$_RunGroup _value, $Res Function(_$_RunGroup) _then)
      : super(_value, (v) => _then(v as _$_RunGroup));

  @override
  _$_RunGroup get _value => super._value as _$_RunGroup;

  @override
  $Res call({
    Object? type = freezed,
    Object? timeOfDay = freezed,
    Object? zoneIds = freezed,
    Object? duration = freezed,
  }) {
    return _then(_$_RunGroup(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as RunGroupType,
      timeOfDay: timeOfDay == freezed
          ? _value.timeOfDay
          : timeOfDay // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      zoneIds: zoneIds == freezed
          ? _value._zoneIds
          : zoneIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc

class _$_RunGroup implements _RunGroup {
  _$_RunGroup(
      {required this.type,
      required this.timeOfDay,
      required final List<int> zoneIds,
      required this.duration})
      : _zoneIds = zoneIds;

  @override
  final RunGroupType type;
  @override
  final TimeOfDay timeOfDay;
  final List<int> _zoneIds;
  @override
  List<int> get zoneIds {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_zoneIds);
  }

  @override
  final Duration duration;

  @override
  String toString() {
    return 'RunGroup(type: $type, timeOfDay: $timeOfDay, zoneIds: $zoneIds, duration: $duration)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RunGroup &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.timeOfDay, timeOfDay) &&
            const DeepCollectionEquality().equals(other._zoneIds, _zoneIds) &&
            const DeepCollectionEquality().equals(other.duration, duration));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(timeOfDay),
      const DeepCollectionEquality().hash(_zoneIds),
      const DeepCollectionEquality().hash(duration));

  @JsonKey(ignore: true)
  @override
  _$$_RunGroupCopyWith<_$_RunGroup> get copyWith =>
      __$$_RunGroupCopyWithImpl<_$_RunGroup>(this, _$identity);
}

abstract class _RunGroup implements RunGroup {
  factory _RunGroup(
      {required final RunGroupType type,
      required final TimeOfDay timeOfDay,
      required final List<int> zoneIds,
      required final Duration duration}) = _$_RunGroup;

  @override
  RunGroupType get type;
  @override
  TimeOfDay get timeOfDay;
  @override
  List<int> get zoneIds;
  @override
  Duration get duration;
  @override
  @JsonKey(ignore: true)
  _$$_RunGroupCopyWith<_$_RunGroup> get copyWith =>
      throw _privateConstructorUsedError;
}
