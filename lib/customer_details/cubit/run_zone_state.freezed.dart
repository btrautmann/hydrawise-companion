// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'run_zone_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$RunZoneStateTearOff {
  const _$RunZoneStateTearOff();

  _Resting resting({String? message}) {
    return _Resting(
      message: message,
    );
  }

  _Loading loading() {
    return _Loading();
  }
}

/// @nodoc
const $RunZoneState = _$RunZoneStateTearOff();

/// @nodoc
mixin _$RunZoneState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) resting,
    required TResult Function() loading,
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
abstract class _$RestingCopyWith<$Res> {
  factory _$RestingCopyWith(_Resting value, $Res Function(_Resting) then) =
      __$RestingCopyWithImpl<$Res>;
  $Res call({String? message});
}

/// @nodoc
class __$RestingCopyWithImpl<$Res> extends _$RunZoneStateCopyWithImpl<$Res>
    implements _$RestingCopyWith<$Res> {
  __$RestingCopyWithImpl(_Resting _value, $Res Function(_Resting) _then)
      : super(_value, (v) => _then(v as _Resting));

  @override
  _Resting get _value => super._value as _Resting;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_Resting(
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
        (other is _Resting &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);

  @JsonKey(ignore: true)
  @override
  _$RestingCopyWith<_Resting> get copyWith =>
      __$RestingCopyWithImpl<_Resting>(this, _$identity);

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
  factory _Resting({String? message}) = _$_Resting;

  String? get message => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$RestingCopyWith<_Resting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$LoadingCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) then) =
      __$LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$LoadingCopyWithImpl<$Res> extends _$RunZoneStateCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(_Loading _value, $Res Function(_Loading) _then)
      : super(_value, (v) => _then(v as _Loading));

  @override
  _Loading get _value => super._value as _Loading;
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
    return identical(this, other) || (other is _Loading);
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
