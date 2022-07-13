// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'zone.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Zone _$ZoneFromJson(Map<String, dynamic> json) {
  return _Zone.fromJson(json);
}

/// @nodoc
mixin _$Zone {
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'zone_num')
  int get number => throw _privateConstructorUsedError;
  @JsonKey(name: 'zone_name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'time_until_run_sec')
  int get timeUntilNextRunSec => throw _privateConstructorUsedError;
  @JsonKey(name: 'run_length_sec')
  int get runLengthSec => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ZoneCopyWith<Zone> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ZoneCopyWith<$Res> {
  factory $ZoneCopyWith(Zone value, $Res Function(Zone) then) =
      _$ZoneCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'id') int id,
      @JsonKey(name: 'zone_num') int number,
      @JsonKey(name: 'zone_name') String name,
      @JsonKey(name: 'time_until_run_sec') int timeUntilNextRunSec,
      @JsonKey(name: 'run_length_sec') int runLengthSec});
}

/// @nodoc
class _$ZoneCopyWithImpl<$Res> implements $ZoneCopyWith<$Res> {
  _$ZoneCopyWithImpl(this._value, this._then);

  final Zone _value;
  // ignore: unused_field
  final $Res Function(Zone) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? number = freezed,
    Object? name = freezed,
    Object? timeUntilNextRunSec = freezed,
    Object? runLengthSec = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      number: number == freezed
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      timeUntilNextRunSec: timeUntilNextRunSec == freezed
          ? _value.timeUntilNextRunSec
          : timeUntilNextRunSec // ignore: cast_nullable_to_non_nullable
              as int,
      runLengthSec: runLengthSec == freezed
          ? _value.runLengthSec
          : runLengthSec // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_ZoneCopyWith<$Res> implements $ZoneCopyWith<$Res> {
  factory _$$_ZoneCopyWith(_$_Zone value, $Res Function(_$_Zone) then) =
      __$$_ZoneCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'id') int id,
      @JsonKey(name: 'zone_num') int number,
      @JsonKey(name: 'zone_name') String name,
      @JsonKey(name: 'time_until_run_sec') int timeUntilNextRunSec,
      @JsonKey(name: 'run_length_sec') int runLengthSec});
}

/// @nodoc
class __$$_ZoneCopyWithImpl<$Res> extends _$ZoneCopyWithImpl<$Res>
    implements _$$_ZoneCopyWith<$Res> {
  __$$_ZoneCopyWithImpl(_$_Zone _value, $Res Function(_$_Zone) _then)
      : super(_value, (v) => _then(v as _$_Zone));

  @override
  _$_Zone get _value => super._value as _$_Zone;

  @override
  $Res call({
    Object? id = freezed,
    Object? number = freezed,
    Object? name = freezed,
    Object? timeUntilNextRunSec = freezed,
    Object? runLengthSec = freezed,
  }) {
    return _then(_$_Zone(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      number: number == freezed
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      timeUntilNextRunSec: timeUntilNextRunSec == freezed
          ? _value.timeUntilNextRunSec
          : timeUntilNextRunSec // ignore: cast_nullable_to_non_nullable
              as int,
      runLengthSec: runLengthSec == freezed
          ? _value.runLengthSec
          : runLengthSec // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Zone implements _Zone {
  _$_Zone(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'zone_num') required this.number,
      @JsonKey(name: 'zone_name') required this.name,
      @JsonKey(name: 'time_until_run_sec') required this.timeUntilNextRunSec,
      @JsonKey(name: 'run_length_sec') required this.runLengthSec});

  factory _$_Zone.fromJson(Map<String, dynamic> json) => _$$_ZoneFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int id;
  @override
  @JsonKey(name: 'zone_num')
  final int number;
  @override
  @JsonKey(name: 'zone_name')
  final String name;
  @override
  @JsonKey(name: 'time_until_run_sec')
  final int timeUntilNextRunSec;
  @override
  @JsonKey(name: 'run_length_sec')
  final int runLengthSec;

  @override
  String toString() {
    return 'Zone(id: $id, number: $number, name: $name, timeUntilNextRunSec: $timeUntilNextRunSec, runLengthSec: $runLengthSec)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Zone &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.number, number) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.timeUntilNextRunSec, timeUntilNextRunSec) &&
            const DeepCollectionEquality()
                .equals(other.runLengthSec, runLengthSec));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(number),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(timeUntilNextRunSec),
      const DeepCollectionEquality().hash(runLengthSec));

  @JsonKey(ignore: true)
  @override
  _$$_ZoneCopyWith<_$_Zone> get copyWith =>
      __$$_ZoneCopyWithImpl<_$_Zone>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ZoneToJson(this);
  }
}

abstract class _Zone implements Zone {
  factory _Zone(
      {@JsonKey(name: 'id')
          required final int id,
      @JsonKey(name: 'zone_num')
          required final int number,
      @JsonKey(name: 'zone_name')
          required final String name,
      @JsonKey(name: 'time_until_run_sec')
          required final int timeUntilNextRunSec,
      @JsonKey(name: 'run_length_sec')
          required final int runLengthSec}) = _$_Zone;

  factory _Zone.fromJson(Map<String, dynamic> json) = _$_Zone.fromJson;

  @override
  @JsonKey(name: 'id')
  int get id;
  @override
  @JsonKey(name: 'zone_num')
  int get number;
  @override
  @JsonKey(name: 'zone_name')
  String get name;
  @override
  @JsonKey(name: 'time_until_run_sec')
  int get timeUntilNextRunSec;
  @override
  @JsonKey(name: 'run_length_sec')
  int get runLengthSec;
  @override
  @JsonKey(ignore: true)
  _$$_ZoneCopyWith<_$_Zone> get copyWith => throw _privateConstructorUsedError;
}
