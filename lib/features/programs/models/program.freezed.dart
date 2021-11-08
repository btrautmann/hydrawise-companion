// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'program.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ProgramTearOff {
  const _$ProgramTearOff();

  _Program call(
      {required String name,
      required Frequency frequency,
      required List<StartTime> startTimes}) {
    return _Program(
      name: name,
      frequency: frequency,
      startTimes: startTimes,
    );
  }
}

/// @nodoc
const $Program = _$ProgramTearOff();

/// @nodoc
mixin _$Program {
  String get name =>
      throw _privateConstructorUsedError; // PRIMARY ID in `programs`
  Frequency get frequency =>
      throw _privateConstructorUsedError; // INTEGER COLUMN in `programs` (0/1)
  List<StartTime> get startTimes => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProgramCopyWith<Program> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgramCopyWith<$Res> {
  factory $ProgramCopyWith(Program value, $Res Function(Program) then) =
      _$ProgramCopyWithImpl<$Res>;
  $Res call({String name, Frequency frequency, List<StartTime> startTimes});

  $FrequencyCopyWith<$Res> get frequency;
}

/// @nodoc
class _$ProgramCopyWithImpl<$Res> implements $ProgramCopyWith<$Res> {
  _$ProgramCopyWithImpl(this._value, this._then);

  final Program _value;
  // ignore: unused_field
  final $Res Function(Program) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? frequency = freezed,
    Object? startTimes = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      frequency: frequency == freezed
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as Frequency,
      startTimes: startTimes == freezed
          ? _value.startTimes
          : startTimes // ignore: cast_nullable_to_non_nullable
              as List<StartTime>,
    ));
  }

  @override
  $FrequencyCopyWith<$Res> get frequency {
    return $FrequencyCopyWith<$Res>(_value.frequency, (value) {
      return _then(_value.copyWith(frequency: value));
    });
  }
}

/// @nodoc
abstract class _$ProgramCopyWith<$Res> implements $ProgramCopyWith<$Res> {
  factory _$ProgramCopyWith(_Program value, $Res Function(_Program) then) =
      __$ProgramCopyWithImpl<$Res>;
  @override
  $Res call({String name, Frequency frequency, List<StartTime> startTimes});

  @override
  $FrequencyCopyWith<$Res> get frequency;
}

/// @nodoc
class __$ProgramCopyWithImpl<$Res> extends _$ProgramCopyWithImpl<$Res>
    implements _$ProgramCopyWith<$Res> {
  __$ProgramCopyWithImpl(_Program _value, $Res Function(_Program) _then)
      : super(_value, (v) => _then(v as _Program));

  @override
  _Program get _value => super._value as _Program;

  @override
  $Res call({
    Object? name = freezed,
    Object? frequency = freezed,
    Object? startTimes = freezed,
  }) {
    return _then(_Program(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      frequency: frequency == freezed
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as Frequency,
      startTimes: startTimes == freezed
          ? _value.startTimes
          : startTimes // ignore: cast_nullable_to_non_nullable
              as List<StartTime>,
    ));
  }
}

/// @nodoc

class _$_Program implements _Program {
  _$_Program(
      {required this.name, required this.frequency, required this.startTimes});

  @override
  final String name;
  @override // PRIMARY ID in `programs`
  final Frequency frequency;
  @override // INTEGER COLUMN in `programs` (0/1)
  final List<StartTime> startTimes;

  @override
  String toString() {
    return 'Program(name: $name, frequency: $frequency, startTimes: $startTimes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Program &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.frequency, frequency) ||
                const DeepCollectionEquality()
                    .equals(other.frequency, frequency)) &&
            (identical(other.startTimes, startTimes) ||
                const DeepCollectionEquality()
                    .equals(other.startTimes, startTimes)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(frequency) ^
      const DeepCollectionEquality().hash(startTimes);

  @JsonKey(ignore: true)
  @override
  _$ProgramCopyWith<_Program> get copyWith =>
      __$ProgramCopyWithImpl<_Program>(this, _$identity);
}

abstract class _Program implements Program {
  factory _Program(
      {required String name,
      required Frequency frequency,
      required List<StartTime> startTimes}) = _$_Program;

  @override
  String get name => throw _privateConstructorUsedError;
  @override // PRIMARY ID in `programs`
  Frequency get frequency => throw _privateConstructorUsedError;
  @override // INTEGER COLUMN in `programs` (0/1)
  List<StartTime> get startTimes => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ProgramCopyWith<_Program> get copyWith =>
      throw _privateConstructorUsedError;
}
