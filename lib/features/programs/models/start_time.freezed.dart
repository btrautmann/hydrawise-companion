// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'start_time.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$StartTimeTearOff {
  const _$StartTimeTearOff();

  _StartTime call(
      {required String id,
      required TimeOfDay time,
      required List<int> zoneIds}) {
    return _StartTime(
      id: id,
      time: time,
      zoneIds: zoneIds,
    );
  }
}

/// @nodoc
const $StartTime = _$StartTimeTearOff();

/// @nodoc
mixin _$StartTime {
  String get id => throw _privateConstructorUsedError;
  TimeOfDay get time =>
      throw _privateConstructorUsedError; // TEXT COLUMN in `program_start_times`
  List<int> get zoneIds => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StartTimeCopyWith<StartTime> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StartTimeCopyWith<$Res> {
  factory $StartTimeCopyWith(StartTime value, $Res Function(StartTime) then) =
      _$StartTimeCopyWithImpl<$Res>;
  $Res call({String id, TimeOfDay time, List<int> zoneIds});
}

/// @nodoc
class _$StartTimeCopyWithImpl<$Res> implements $StartTimeCopyWith<$Res> {
  _$StartTimeCopyWithImpl(this._value, this._then);

  final StartTime _value;
  // ignore: unused_field
  final $Res Function(StartTime) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? time = freezed,
    Object? zoneIds = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      time: time == freezed
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      zoneIds: zoneIds == freezed
          ? _value.zoneIds
          : zoneIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
abstract class _$StartTimeCopyWith<$Res> implements $StartTimeCopyWith<$Res> {
  factory _$StartTimeCopyWith(
          _StartTime value, $Res Function(_StartTime) then) =
      __$StartTimeCopyWithImpl<$Res>;
  @override
  $Res call({String id, TimeOfDay time, List<int> zoneIds});
}

/// @nodoc
class __$StartTimeCopyWithImpl<$Res> extends _$StartTimeCopyWithImpl<$Res>
    implements _$StartTimeCopyWith<$Res> {
  __$StartTimeCopyWithImpl(_StartTime _value, $Res Function(_StartTime) _then)
      : super(_value, (v) => _then(v as _StartTime));

  @override
  _StartTime get _value => super._value as _StartTime;

  @override
  $Res call({
    Object? id = freezed,
    Object? time = freezed,
    Object? zoneIds = freezed,
  }) {
    return _then(_StartTime(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      time: time == freezed
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      zoneIds: zoneIds == freezed
          ? _value.zoneIds
          : zoneIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc

class _$_StartTime implements _StartTime {
  _$_StartTime({required this.id, required this.time, required this.zoneIds});

  @override
  final String id;
  @override
  final TimeOfDay time;
  @override // TEXT COLUMN in `program_start_times`
  final List<int> zoneIds;

  @override
  String toString() {
    return 'StartTime(id: $id, time: $time, zoneIds: $zoneIds)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _StartTime &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.time, time) ||
                const DeepCollectionEquality().equals(other.time, time)) &&
            (identical(other.zoneIds, zoneIds) ||
                const DeepCollectionEquality().equals(other.zoneIds, zoneIds)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(time) ^
      const DeepCollectionEquality().hash(zoneIds);

  @JsonKey(ignore: true)
  @override
  _$StartTimeCopyWith<_StartTime> get copyWith =>
      __$StartTimeCopyWithImpl<_StartTime>(this, _$identity);
}

abstract class _StartTime implements StartTime {
  factory _StartTime(
      {required String id,
      required TimeOfDay time,
      required List<int> zoneIds}) = _$_StartTime;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  TimeOfDay get time => throw _privateConstructorUsedError;
  @override // TEXT COLUMN in `program_start_times`
  List<int> get zoneIds => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$StartTimeCopyWith<_StartTime> get copyWith =>
      throw _privateConstructorUsedError;
}
