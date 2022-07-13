// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'run_zone_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RunZoneState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) resting,
    required TResult Function() loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String? message)? resting,
    TResult Function()? loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? resting,
    TResult Function()? loading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Resting value) resting,
    required TResult Function(_Loading value) loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Resting value)? resting,
    TResult Function(_Loading value)? loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Resting value)? resting,
    TResult Function(_Loading value)? loading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RunZoneStateCopyWith<$Res> {
  factory $RunZoneStateCopyWith(
          RunZoneState value, $Res Function(RunZoneState) then) =
      _$RunZoneStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$RunZoneStateCopyWithImpl<$Res> implements $RunZoneStateCopyWith<$Res> {
  _$RunZoneStateCopyWithImpl(this._value, this._then);

  final RunZoneState _value;
  // ignore: unused_field
  final $Res Function(RunZoneState) _then;
}

/// @nodoc
abstract class _$$_RestingCopyWith<$Res> {
  factory _$$_RestingCopyWith(
          _$_Resting value, $Res Function(_$_Resting) then) =
      __$$_RestingCopyWithImpl<$Res>;
  $Res call({String? message});
}

/// @nodoc
class __$$_RestingCopyWithImpl<$Res> extends _$RunZoneStateCopyWithImpl<$Res>
    implements _$$_RestingCopyWith<$Res> {
  __$$_RestingCopyWithImpl(_$_Resting _value, $Res Function(_$_Resting) _then)
      : super(_value, (v) => _then(v as _$_Resting));

  @override
  _$_Resting get _value => super._value as _$_Resting;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$_Resting(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_Resting implements _Resting {
  _$_Resting({this.message});

  @override
  final String? message;

  @override
  String toString() {
    return 'RunZoneState.resting(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Resting &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$$_RestingCopyWith<_$_Resting> get copyWith =>
      __$$_RestingCopyWithImpl<_$_Resting>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) resting,
    required TResult Function() loading,
  }) {
    return resting(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String? message)? resting,
    TResult Function()? loading,
  }) {
    return resting?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? resting,
    TResult Function()? loading,
    required TResult orElse(),
  }) {
    if (resting != null) {
      return resting(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Resting value) resting,
    required TResult Function(_Loading value) loading,
  }) {
    return resting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Resting value)? resting,
    TResult Function(_Loading value)? loading,
  }) {
    return resting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Resting value)? resting,
    TResult Function(_Loading value)? loading,
    required TResult orElse(),
  }) {
    if (resting != null) {
      return resting(this);
    }
    return orElse();
  }
}

abstract class _Resting implements RunZoneState {
  factory _Resting({final String? message}) = _$_Resting;

  String? get message;
  @JsonKey(ignore: true)
  _$$_RestingCopyWith<_$_Resting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_LoadingCopyWith<$Res> {
  factory _$$_LoadingCopyWith(
          _$_Loading value, $Res Function(_$_Loading) then) =
      __$$_LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_LoadingCopyWithImpl<$Res> extends _$RunZoneStateCopyWithImpl<$Res>
    implements _$$_LoadingCopyWith<$Res> {
  __$$_LoadingCopyWithImpl(_$_Loading _value, $Res Function(_$_Loading) _then)
      : super(_value, (v) => _then(v as _$_Loading));

  @override
  _$_Loading get _value => super._value as _$_Loading;
}

/// @nodoc

class _$_Loading implements _Loading {
  _$_Loading();

  @override
  String toString() {
    return 'RunZoneState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) resting,
    required TResult Function() loading,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String? message)? resting,
    TResult Function()? loading,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? resting,
    TResult Function()? loading,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Resting value) resting,
    required TResult Function(_Loading value) loading,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Resting value)? resting,
    TResult Function(_Loading value)? loading,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Resting value)? resting,
    TResult Function(_Loading value)? loading,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements RunZoneState {
  factory _Loading() = _$_Loading;
}
