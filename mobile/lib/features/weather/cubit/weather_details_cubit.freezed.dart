// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'weather_details_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$WeatherDetailsStateTearOff {
  const _$WeatherDetailsStateTearOff();

  _NoLocationInformation noLocationInformation() {
    return _NoLocationInformation();
  }

  _Loading loading() {
    return _Loading();
  }

  _Error error(String message) {
    return _Error(
      message,
    );
  }

  _Complete complete({required List<Weather> fiveDayForecast}) {
    return _Complete(
      fiveDayForecast: fiveDayForecast,
    );
  }
}

/// @nodoc
const $WeatherDetailsState = _$WeatherDetailsStateTearOff();

/// @nodoc
mixin _$WeatherDetailsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() noLocationInformation,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(List<Weather> fiveDayForecast) complete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? noLocationInformation,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(List<Weather> fiveDayForecast)? complete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? noLocationInformation,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(List<Weather> fiveDayForecast)? complete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NoLocationInformation value)
        noLocationInformation,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Error value) error,
    required TResult Function(_Complete value) complete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_NoLocationInformation value)? noLocationInformation,
    TResult Function(_Loading value)? loading,
    TResult Function(_Error value)? error,
    TResult Function(_Complete value)? complete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NoLocationInformation value)? noLocationInformation,
    TResult Function(_Loading value)? loading,
    TResult Function(_Error value)? error,
    TResult Function(_Complete value)? complete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherDetailsStateCopyWith<$Res> {
  factory $WeatherDetailsStateCopyWith(
          WeatherDetailsState value, $Res Function(WeatherDetailsState) then) =
      _$WeatherDetailsStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$WeatherDetailsStateCopyWithImpl<$Res>
    implements $WeatherDetailsStateCopyWith<$Res> {
  _$WeatherDetailsStateCopyWithImpl(this._value, this._then);

  final WeatherDetailsState _value;
  // ignore: unused_field
  final $Res Function(WeatherDetailsState) _then;
}

/// @nodoc
abstract class _$NoLocationInformationCopyWith<$Res> {
  factory _$NoLocationInformationCopyWith(_NoLocationInformation value,
          $Res Function(_NoLocationInformation) then) =
      __$NoLocationInformationCopyWithImpl<$Res>;
}

/// @nodoc
class __$NoLocationInformationCopyWithImpl<$Res>
    extends _$WeatherDetailsStateCopyWithImpl<$Res>
    implements _$NoLocationInformationCopyWith<$Res> {
  __$NoLocationInformationCopyWithImpl(_NoLocationInformation _value,
      $Res Function(_NoLocationInformation) _then)
      : super(_value, (v) => _then(v as _NoLocationInformation));

  @override
  _NoLocationInformation get _value => super._value as _NoLocationInformation;
}

/// @nodoc

class _$_NoLocationInformation implements _NoLocationInformation {
  _$_NoLocationInformation();

  @override
  String toString() {
    return 'WeatherDetailsState.noLocationInformation()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _NoLocationInformation);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() noLocationInformation,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(List<Weather> fiveDayForecast) complete,
  }) {
    return noLocationInformation();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? noLocationInformation,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(List<Weather> fiveDayForecast)? complete,
  }) {
    return noLocationInformation?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? noLocationInformation,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(List<Weather> fiveDayForecast)? complete,
    required TResult orElse(),
  }) {
    if (noLocationInformation != null) {
      return noLocationInformation();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NoLocationInformation value)
        noLocationInformation,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Error value) error,
    required TResult Function(_Complete value) complete,
  }) {
    return noLocationInformation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_NoLocationInformation value)? noLocationInformation,
    TResult Function(_Loading value)? loading,
    TResult Function(_Error value)? error,
    TResult Function(_Complete value)? complete,
  }) {
    return noLocationInformation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NoLocationInformation value)? noLocationInformation,
    TResult Function(_Loading value)? loading,
    TResult Function(_Error value)? error,
    TResult Function(_Complete value)? complete,
    required TResult orElse(),
  }) {
    if (noLocationInformation != null) {
      return noLocationInformation(this);
    }
    return orElse();
  }
}

abstract class _NoLocationInformation implements WeatherDetailsState {
  factory _NoLocationInformation() = _$_NoLocationInformation;
}

/// @nodoc
abstract class _$LoadingCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) then) =
      __$LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$LoadingCopyWithImpl<$Res>
    extends _$WeatherDetailsStateCopyWithImpl<$Res>
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
    return 'WeatherDetailsState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() noLocationInformation,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(List<Weather> fiveDayForecast) complete,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? noLocationInformation,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(List<Weather> fiveDayForecast)? complete,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? noLocationInformation,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(List<Weather> fiveDayForecast)? complete,
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
    required TResult Function(_NoLocationInformation value)
        noLocationInformation,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Error value) error,
    required TResult Function(_Complete value) complete,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_NoLocationInformation value)? noLocationInformation,
    TResult Function(_Loading value)? loading,
    TResult Function(_Error value)? error,
    TResult Function(_Complete value)? complete,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NoLocationInformation value)? noLocationInformation,
    TResult Function(_Loading value)? loading,
    TResult Function(_Error value)? error,
    TResult Function(_Complete value)? complete,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements WeatherDetailsState {
  factory _Loading() = _$_Loading;
}

/// @nodoc
abstract class _$ErrorCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) then) =
      __$ErrorCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class __$ErrorCopyWithImpl<$Res> extends _$WeatherDetailsStateCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(_Error _value, $Res Function(_Error) _then)
      : super(_value, (v) => _then(v as _Error));

  @override
  _Error get _value => super._value as _Error;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_Error(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Error implements _Error {
  _$_Error(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'WeatherDetailsState.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Error &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$ErrorCopyWith<_Error> get copyWith =>
      __$ErrorCopyWithImpl<_Error>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() noLocationInformation,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(List<Weather> fiveDayForecast) complete,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? noLocationInformation,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(List<Weather> fiveDayForecast)? complete,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? noLocationInformation,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(List<Weather> fiveDayForecast)? complete,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NoLocationInformation value)
        noLocationInformation,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Error value) error,
    required TResult Function(_Complete value) complete,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_NoLocationInformation value)? noLocationInformation,
    TResult Function(_Loading value)? loading,
    TResult Function(_Error value)? error,
    TResult Function(_Complete value)? complete,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NoLocationInformation value)? noLocationInformation,
    TResult Function(_Loading value)? loading,
    TResult Function(_Error value)? error,
    TResult Function(_Complete value)? complete,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements WeatherDetailsState {
  factory _Error(String message) = _$_Error;

  String get message;
  @JsonKey(ignore: true)
  _$ErrorCopyWith<_Error> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$CompleteCopyWith<$Res> {
  factory _$CompleteCopyWith(_Complete value, $Res Function(_Complete) then) =
      __$CompleteCopyWithImpl<$Res>;
  $Res call({List<Weather> fiveDayForecast});
}

/// @nodoc
class __$CompleteCopyWithImpl<$Res>
    extends _$WeatherDetailsStateCopyWithImpl<$Res>
    implements _$CompleteCopyWith<$Res> {
  __$CompleteCopyWithImpl(_Complete _value, $Res Function(_Complete) _then)
      : super(_value, (v) => _then(v as _Complete));

  @override
  _Complete get _value => super._value as _Complete;

  @override
  $Res call({
    Object? fiveDayForecast = freezed,
  }) {
    return _then(_Complete(
      fiveDayForecast: fiveDayForecast == freezed
          ? _value.fiveDayForecast
          : fiveDayForecast // ignore: cast_nullable_to_non_nullable
              as List<Weather>,
    ));
  }
}

/// @nodoc

class _$_Complete implements _Complete {
  _$_Complete({required this.fiveDayForecast});

  @override
  final List<Weather> fiveDayForecast;

  @override
  String toString() {
    return 'WeatherDetailsState.complete(fiveDayForecast: $fiveDayForecast)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Complete &&
            const DeepCollectionEquality()
                .equals(other.fiveDayForecast, fiveDayForecast));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(fiveDayForecast));

  @JsonKey(ignore: true)
  @override
  _$CompleteCopyWith<_Complete> get copyWith =>
      __$CompleteCopyWithImpl<_Complete>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() noLocationInformation,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(List<Weather> fiveDayForecast) complete,
  }) {
    return complete(fiveDayForecast);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? noLocationInformation,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(List<Weather> fiveDayForecast)? complete,
  }) {
    return complete?.call(fiveDayForecast);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? noLocationInformation,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(List<Weather> fiveDayForecast)? complete,
    required TResult orElse(),
  }) {
    if (complete != null) {
      return complete(fiveDayForecast);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NoLocationInformation value)
        noLocationInformation,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Error value) error,
    required TResult Function(_Complete value) complete,
  }) {
    return complete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_NoLocationInformation value)? noLocationInformation,
    TResult Function(_Loading value)? loading,
    TResult Function(_Error value)? error,
    TResult Function(_Complete value)? complete,
  }) {
    return complete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NoLocationInformation value)? noLocationInformation,
    TResult Function(_Loading value)? loading,
    TResult Function(_Error value)? error,
    TResult Function(_Complete value)? complete,
    required TResult orElse(),
  }) {
    if (complete != null) {
      return complete(this);
    }
    return orElse();
  }
}

abstract class _Complete implements WeatherDetailsState {
  factory _Complete({required List<Weather> fiveDayForecast}) = _$_Complete;

  List<Weather> get fiveDayForecast;
  @JsonKey(ignore: true)
  _$CompleteCopyWith<_Complete> get copyWith =>
      throw _privateConstructorUsedError;
}
