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
      {required String id,
      required String name,
      required Frequency frequency,
      required List<Run> runs}) {
    return _Program(
      id: id,
      name: name,
      frequency: frequency,
      runs: runs,
    );
  }
}

/// @nodoc
const $Program = _$ProgramTearOff();

/// @nodoc
mixin _$Program {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  Frequency get frequency => throw _privateConstructorUsedError;
  List<Run> get runs => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProgramCopyWith<Program> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgramCopyWith<$Res> {
  factory $ProgramCopyWith(Program value, $Res Function(Program) then) =
      _$ProgramCopyWithImpl<$Res>;
  $Res call({String id, String name, Frequency frequency, List<Run> runs});

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
    Object? id = freezed,
    Object? name = freezed,
    Object? frequency = freezed,
    Object? runs = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      frequency: frequency == freezed
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as Frequency,
      runs: runs == freezed
          ? _value.runs
          : runs // ignore: cast_nullable_to_non_nullable
              as List<Run>,
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
  $Res call({String id, String name, Frequency frequency, List<Run> runs});

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
    Object? id = freezed,
    Object? name = freezed,
    Object? frequency = freezed,
    Object? runs = freezed,
  }) {
    return _then(_Program(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      frequency: frequency == freezed
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as Frequency,
      runs: runs == freezed
          ? _value.runs
          : runs // ignore: cast_nullable_to_non_nullable
              as List<Run>,
    ));
  }
}

/// @nodoc

class _$_Program implements _Program {
  _$_Program(
      {required this.id,
      required this.name,
      required this.frequency,
      required this.runs});

  @override
  final String id;
  @override
  final String name;
  @override
  final Frequency frequency;
  @override
  final List<Run> runs;

  @override
  String toString() {
    return 'Program(id: $id, name: $name, frequency: $frequency, runs: $runs)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Program &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.frequency, frequency) ||
                const DeepCollectionEquality()
                    .equals(other.frequency, frequency)) &&
            (identical(other.runs, runs) ||
                const DeepCollectionEquality().equals(other.runs, runs)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(frequency) ^
      const DeepCollectionEquality().hash(runs);

  @JsonKey(ignore: true)
  @override
  _$ProgramCopyWith<_Program> get copyWith =>
      __$ProgramCopyWithImpl<_Program>(this, _$identity);
}

abstract class _Program implements Program {
  factory _Program(
      {required String id,
      required String name,
      required Frequency frequency,
      required List<Run> runs}) = _$_Program;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  Frequency get frequency => throw _privateConstructorUsedError;
  @override
  List<Run> get runs => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ProgramCopyWith<_Program> get copyWith =>
      throw _privateConstructorUsedError;
}