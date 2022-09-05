// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'providers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ProgramsState {
  List<Program> get programs => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProgramsStateCopyWith<ProgramsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgramsStateCopyWith<$Res> {
  factory $ProgramsStateCopyWith(
          ProgramsState value, $Res Function(ProgramsState) then) =
      _$ProgramsStateCopyWithImpl<$Res>;
  $Res call({List<Program> programs});
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
  }) {
    return _then(_value.copyWith(
      programs: programs == freezed
          ? _value.programs
          : programs // ignore: cast_nullable_to_non_nullable
              as List<Program>,
    ));
  }
}

/// @nodoc
abstract class _$$_ProgramsStateCopyWith<$Res>
    implements $ProgramsStateCopyWith<$Res> {
  factory _$$_ProgramsStateCopyWith(
          _$_ProgramsState value, $Res Function(_$_ProgramsState) then) =
      __$$_ProgramsStateCopyWithImpl<$Res>;
  @override
  $Res call({List<Program> programs});
}

/// @nodoc
class __$$_ProgramsStateCopyWithImpl<$Res>
    extends _$ProgramsStateCopyWithImpl<$Res>
    implements _$$_ProgramsStateCopyWith<$Res> {
  __$$_ProgramsStateCopyWithImpl(
      _$_ProgramsState _value, $Res Function(_$_ProgramsState) _then)
      : super(_value, (v) => _then(v as _$_ProgramsState));

  @override
  _$_ProgramsState get _value => super._value as _$_ProgramsState;

  @override
  $Res call({
    Object? programs = freezed,
  }) {
    return _then(_$_ProgramsState(
      programs: programs == freezed
          ? _value._programs
          : programs // ignore: cast_nullable_to_non_nullable
              as List<Program>,
    ));
  }
}

/// @nodoc

class _$_ProgramsState implements _ProgramsState {
  _$_ProgramsState({required final List<Program> programs})
      : _programs = programs;

  final List<Program> _programs;
  @override
  List<Program> get programs {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_programs);
  }

  @override
  String toString() {
    return 'ProgramsState(programs: $programs)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProgramsState &&
            const DeepCollectionEquality().equals(other._programs, _programs));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_programs));

  @JsonKey(ignore: true)
  @override
  _$$_ProgramsStateCopyWith<_$_ProgramsState> get copyWith =>
      __$$_ProgramsStateCopyWithImpl<_$_ProgramsState>(this, _$identity);
}

abstract class _ProgramsState implements ProgramsState {
  factory _ProgramsState({required final List<Program> programs}) =
      _$_ProgramsState;

  @override
  List<Program> get programs;
  @override
  @JsonKey(ignore: true)
  _$$_ProgramsStateCopyWith<_$_ProgramsState> get copyWith =>
      throw _privateConstructorUsedError;
}
