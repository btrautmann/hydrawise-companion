// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'run.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Run _$RunFromJson(Map<String, dynamic> json) {
  return _Run.fromJson(json);
}

/// @nodoc
class _$RunTearOff {
  const _$RunTearOff();

  _Run call(
      {@JsonKey(name: 'id')
          required String id,
      @JsonKey(name: 'p_id')
          required String programId,
      @JsonKey(name: 'start_time', toJson: TimeOfDayX.toJson, fromJson: TimeOfDayX.fromJson)
          required TimeOfDay startTime,
      @JsonKey(name: 'duration')
          required int duration,
      @JsonKey(name: 'z_id')
          required int zoneId}) {
    return _Run(
      id: id,
      programId: programId,
      startTime: startTime,
      duration: duration,
      zoneId: zoneId,
    );
  }

  Run fromJson(Map<String, Object?> json) {
    return Run.fromJson(json);
  }
}

/// @nodoc
const $Run = _$RunTearOff();

/// @nodoc
mixin _$Run {
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'p_id')
  String get programId => throw _privateConstructorUsedError;
  @JsonKey(
      name: 'start_time',
      toJson: TimeOfDayX.toJson,
      fromJson: TimeOfDayX.fromJson)
  TimeOfDay get startTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'duration')
  int get duration => throw _privateConstructorUsedError;
  @JsonKey(name: 'z_id')
  int get zoneId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RunCopyWith<Run> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RunCopyWith<$Res> {
  factory $RunCopyWith(Run value, $Res Function(Run) then) =
      _$RunCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'id')
          String id,
      @JsonKey(name: 'p_id')
          String programId,
      @JsonKey(name: 'start_time', toJson: TimeOfDayX.toJson, fromJson: TimeOfDayX.fromJson)
          TimeOfDay startTime,
      @JsonKey(name: 'duration')
          int duration,
      @JsonKey(name: 'z_id')
          int zoneId});
}

/// @nodoc
class _$RunCopyWithImpl<$Res> implements $RunCopyWith<$Res> {
  _$RunCopyWithImpl(this._value, this._then);

  final Run _value;
  // ignore: unused_field
  final $Res Function(Run) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? programId = freezed,
    Object? startTime = freezed,
    Object? duration = freezed,
    Object? zoneId = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      programId: programId == freezed
          ? _value.programId
          : programId // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: startTime == freezed
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      zoneId: zoneId == freezed
          ? _value.zoneId
          : zoneId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$RunCopyWith<$Res> implements $RunCopyWith<$Res> {
  factory _$RunCopyWith(_Run value, $Res Function(_Run) then) =
      __$RunCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'id')
          String id,
      @JsonKey(name: 'p_id')
          String programId,
      @JsonKey(name: 'start_time', toJson: TimeOfDayX.toJson, fromJson: TimeOfDayX.fromJson)
          TimeOfDay startTime,
      @JsonKey(name: 'duration')
          int duration,
      @JsonKey(name: 'z_id')
          int zoneId});
}

/// @nodoc
class __$RunCopyWithImpl<$Res> extends _$RunCopyWithImpl<$Res>
    implements _$RunCopyWith<$Res> {
  __$RunCopyWithImpl(_Run _value, $Res Function(_Run) _then)
      : super(_value, (v) => _then(v as _Run));

  @override
  _Run get _value => super._value as _Run;

  @override
  $Res call({
    Object? id = freezed,
    Object? programId = freezed,
    Object? startTime = freezed,
    Object? duration = freezed,
    Object? zoneId = freezed,
  }) {
    return _then(_Run(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      programId: programId == freezed
          ? _value.programId
          : programId // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: startTime == freezed
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      zoneId: zoneId == freezed
          ? _value.zoneId
          : zoneId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Run extends _Run {
  _$_Run(
      {@JsonKey(name: 'id')
          required this.id,
      @JsonKey(name: 'p_id')
          required this.programId,
      @JsonKey(name: 'start_time', toJson: TimeOfDayX.toJson, fromJson: TimeOfDayX.fromJson)
          required this.startTime,
      @JsonKey(name: 'duration')
          required this.duration,
      @JsonKey(name: 'z_id')
          required this.zoneId})
      : super._();

  factory _$_Run.fromJson(Map<String, dynamic> json) => _$$_RunFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'p_id')
  final String programId;
  @override
  @JsonKey(
      name: 'start_time',
      toJson: TimeOfDayX.toJson,
      fromJson: TimeOfDayX.fromJson)
  final TimeOfDay startTime;
  @override
  @JsonKey(name: 'duration')
  final int duration;
  @override
  @JsonKey(name: 'z_id')
  final int zoneId;

  @JsonKey(ignore: true)
  @override
  _$RunCopyWith<_Run> get copyWith =>
      __$RunCopyWithImpl<_Run>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RunToJson(this);
  }
}

abstract class _Run extends Run {
  factory _Run(
      {@JsonKey(name: 'id')
          required String id,
      @JsonKey(name: 'p_id')
          required String programId,
      @JsonKey(name: 'start_time', toJson: TimeOfDayX.toJson, fromJson: TimeOfDayX.fromJson)
          required TimeOfDay startTime,
      @JsonKey(name: 'duration')
          required int duration,
      @JsonKey(name: 'z_id')
          required int zoneId}) = _$_Run;
  _Run._() : super._();

  factory _Run.fromJson(Map<String, dynamic> json) = _$_Run.fromJson;

  @override
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'p_id')
  String get programId;
  @override
  @JsonKey(
      name: 'start_time',
      toJson: TimeOfDayX.toJson,
      fromJson: TimeOfDayX.fromJson)
  TimeOfDay get startTime;
  @override
  @JsonKey(name: 'duration')
  int get duration;
  @override
  @JsonKey(name: 'z_id')
  int get zoneId;
  @override
  @JsonKey(ignore: true)
  _$RunCopyWith<_Run> get copyWith => throw _privateConstructorUsedError;
}
