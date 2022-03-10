// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'programs_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ProgramsStateTearOff {
  const _$ProgramsStateTearOff();

  _ProgramsState call(
      {required List<Program> programs,
      List<Program> pendingDeletes = const []}) {
    return _ProgramsState(
      programs: programs,
      pendingDeletes: pendingDeletes,
    );
  }
}

/// @nodoc
const $ProgramsState = _$ProgramsStateTearOff();

/// @nodoc
mixin _$ProgramsState {
  List<Program> get programs => throw _privateConstructorUsedError;
  List<Program> get pendingDeletes => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProgramsStateCopyWith<ProgramsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgramsStateCopyWith<$Res> {
  factory $ProgramsStateCopyWith(
          ProgramsState value, $Res Function(ProgramsState) then) =
      _$ProgramsStateCopyWithImpl<$Res>;
  $Res call({List<Program> programs, List<Program> pendingDeletes});
}

/// @nodoc
class _$ProgramsStateCopyWithImpl<$Res>
    implements $ProgramsStateCopyWith<$Res> {
  _$ProgramsStateCopyWithImpl(this._value, this._then);

  final ProgramsState _value;
  // ignore: unused_field
  final $Res Function(ProgramsState) _then;

  @override
  $Res call({
    Object? programs = freezed,
    Object? pendingDeletes = freezed,
  }) {
    return _then(_value.copyWith(
      programs: programs == freezed
          ? _value.programs
          : programs // ignore: cast_nullable_to_non_nullable
              as List<Program>,
      pendingDeletes: pendingDeletes == freezed
          ? _value.pendingDeletes
          : pendingDeletes // ignore: cast_nullable_to_non_nullable
              as List<Program>,
    ));
  }
}

/// @nodoc
abstract class _$ProgramsStateCopyWith<$Res>
    implements $ProgramsStateCopyWith<$Res> {
  factory _$ProgramsStateCopyWith(
          _ProgramsState value, $Res Function(_ProgramsState) then) =
      __$ProgramsStateCopyWithImpl<$Res>;
  @override
  $Res call({List<Program> programs, List<Program> pendingDeletes});
}

/// @nodoc
class __$ProgramsStateCopyWithImpl<$Res>
    extends _$ProgramsStateCopyWithImpl<$Res>
    implements _$ProgramsStateCopyWith<$Res> {
  __$ProgramsStateCopyWithImpl(
      _ProgramsState _value, $Res Function(_ProgramsState) _then)
      : super(_value, (v) => _then(v as _ProgramsState));

  @override
  _ProgramsState get _value => super._value as _ProgramsState;

  @override
  $Res call({
    Object? programs = freezed,
    Object? pendingDeletes = freezed,
  }) {
    return _then(_ProgramsState(
      programs: programs == freezed
          ? _value.programs
          : programs // ignore: cast_nullable_to_non_nullable
              as List<Program>,
      pendingDeletes: pendingDeletes == freezed
          ? _value.pendingDeletes
          : pendingDeletes // ignore: cast_nullable_to_non_nullable
              as List<Program>,
    ));
  }
}

/// @nodoc

class _$_ProgramsState implements _ProgramsState {
  _$_ProgramsState({required this.programs, this.pendingDeletes = const []});

  @override
  final List<Program> programs;
  @JsonKey(defaultValue: const [])
  @override
  final List<Program> pendingDeletes;

  @override
  String toString() {
    return 'ProgramsState(programs: $programs, pendingDeletes: $pendingDeletes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ProgramsState &&
            (identical(other.programs, programs) ||
                const DeepCollectionEquality()
                    .equals(other.programs, programs)) &&
            (identical(other.pendingDeletes, pendingDeletes) ||
                const DeepCollectionEquality()
                    .equals(other.pendingDeletes, pendingDeletes)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(programs) ^
      const DeepCollectionEquality().hash(pendingDeletes);

  @JsonKey(ignore: true)
  @override
  _$ProgramsStateCopyWith<_ProgramsState> get copyWith =>
      __$ProgramsStateCopyWithImpl<_ProgramsState>(this, _$identity);
}

abstract class _ProgramsState implements ProgramsState {
  factory _ProgramsState(
      {required List<Program> programs,
      List<Program> pendingDeletes}) = _$_ProgramsState;

  @override
  List<Program> get programs => throw _privateConstructorUsedError;
  @override
  List<Program> get pendingDeletes => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ProgramsStateCopyWith<_ProgramsState> get copyWith =>
      throw _privateConstructorUsedError;
}
