// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'login_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$LoginStateTearOff {
  const _$LoginStateTearOff();

  _LoggedIn loggedIn({required String apiKey}) {
    return _LoggedIn(
      apiKey: apiKey,
    );
  }

  _LoggedOut loggedOut() {
    return _LoggedOut();
  }
}

/// @nodoc
const $LoginState = _$LoginStateTearOff();

/// @nodoc
mixin _$LoginState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String apiKey) loggedIn,
    required TResult Function() loggedOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String apiKey)? loggedIn,
    TResult Function()? loggedOut,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoggedIn value) loggedIn,
    required TResult Function(_LoggedOut value) loggedOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoggedIn value)? loggedIn,
    TResult Function(_LoggedOut value)? loggedOut,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginStateCopyWith<$Res> {
  factory $LoginStateCopyWith(
          LoginState value, $Res Function(LoginState) then) =
      _$LoginStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$LoginStateCopyWithImpl<$Res> implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._value, this._then);

  final LoginState _value;
  // ignore: unused_field
  final $Res Function(LoginState) _then;
}

/// @nodoc
abstract class _$LoggedInCopyWith<$Res> {
  factory _$LoggedInCopyWith(_LoggedIn value, $Res Function(_LoggedIn) then) =
      __$LoggedInCopyWithImpl<$Res>;
  $Res call({String apiKey});
}

/// @nodoc
class __$LoggedInCopyWithImpl<$Res> extends _$LoginStateCopyWithImpl<$Res>
    implements _$LoggedInCopyWith<$Res> {
  __$LoggedInCopyWithImpl(_LoggedIn _value, $Res Function(_LoggedIn) _then)
      : super(_value, (v) => _then(v as _LoggedIn));

  @override
  _LoggedIn get _value => super._value as _LoggedIn;

  @override
  $Res call({
    Object? apiKey = freezed,
  }) {
    return _then(_LoggedIn(
      apiKey: apiKey == freezed
          ? _value.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_LoggedIn implements _LoggedIn {
  _$_LoggedIn({required this.apiKey});

  @override
  final String apiKey;

  @override
  String toString() {
    return 'LoginState.loggedIn(apiKey: $apiKey)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _LoggedIn &&
            (identical(other.apiKey, apiKey) ||
                const DeepCollectionEquality().equals(other.apiKey, apiKey)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(apiKey);

  @JsonKey(ignore: true)
  @override
  _$LoggedInCopyWith<_LoggedIn> get copyWith =>
      __$LoggedInCopyWithImpl<_LoggedIn>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String apiKey) loggedIn,
    required TResult Function() loggedOut,
  }) {
    return loggedIn(apiKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String apiKey)? loggedIn,
    TResult Function()? loggedOut,
    required TResult orElse(),
  }) {
    if (loggedIn != null) {
      return loggedIn(apiKey);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoggedIn value) loggedIn,
    required TResult Function(_LoggedOut value) loggedOut,
  }) {
    return loggedIn(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoggedIn value)? loggedIn,
    TResult Function(_LoggedOut value)? loggedOut,
    required TResult orElse(),
  }) {
    if (loggedIn != null) {
      return loggedIn(this);
    }
    return orElse();
  }
}

abstract class _LoggedIn implements LoginState {
  factory _LoggedIn({required String apiKey}) = _$_LoggedIn;

  String get apiKey => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$LoggedInCopyWith<_LoggedIn> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$LoggedOutCopyWith<$Res> {
  factory _$LoggedOutCopyWith(
          _LoggedOut value, $Res Function(_LoggedOut) then) =
      __$LoggedOutCopyWithImpl<$Res>;
}

/// @nodoc
class __$LoggedOutCopyWithImpl<$Res> extends _$LoginStateCopyWithImpl<$Res>
    implements _$LoggedOutCopyWith<$Res> {
  __$LoggedOutCopyWithImpl(_LoggedOut _value, $Res Function(_LoggedOut) _then)
      : super(_value, (v) => _then(v as _LoggedOut));

  @override
  _LoggedOut get _value => super._value as _LoggedOut;
}

/// @nodoc

class _$_LoggedOut implements _LoggedOut {
  _$_LoggedOut();

  @override
  String toString() {
    return 'LoginState.loggedOut()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _LoggedOut);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String apiKey) loggedIn,
    required TResult Function() loggedOut,
  }) {
    return loggedOut();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String apiKey)? loggedIn,
    TResult Function()? loggedOut,
    required TResult orElse(),
  }) {
    if (loggedOut != null) {
      return loggedOut();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoggedIn value) loggedIn,
    required TResult Function(_LoggedOut value) loggedOut,
  }) {
    return loggedOut(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoggedIn value)? loggedIn,
    TResult Function(_LoggedOut value)? loggedOut,
    required TResult orElse(),
  }) {
    if (loggedOut != null) {
      return loggedOut(this);
    }
    return orElse();
  }
}

abstract class _LoggedOut implements LoginState {
  factory _LoggedOut() = _$_LoggedOut;
}
