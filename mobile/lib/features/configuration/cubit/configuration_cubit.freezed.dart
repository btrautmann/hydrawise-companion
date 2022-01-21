// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'configuration_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ConfigurationStateTearOff {
  const _$ConfigurationStateTearOff();

  _ConfigurationState call(
      {bool pushNotificationsEnabled = false, String? timeZone}) {
    return _ConfigurationState(
      pushNotificationsEnabled: pushNotificationsEnabled,
      timeZone: timeZone,
    );
  }
}

/// @nodoc
const $ConfigurationState = _$ConfigurationStateTearOff();

/// @nodoc
mixin _$ConfigurationState {
  bool get pushNotificationsEnabled => throw _privateConstructorUsedError;
  String? get timeZone => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ConfigurationStateCopyWith<ConfigurationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfigurationStateCopyWith<$Res> {
  factory $ConfigurationStateCopyWith(
          ConfigurationState value, $Res Function(ConfigurationState) then) =
      _$ConfigurationStateCopyWithImpl<$Res>;
  $Res call({bool pushNotificationsEnabled, String? timeZone});
}

/// @nodoc
class _$ConfigurationStateCopyWithImpl<$Res>
    implements $ConfigurationStateCopyWith<$Res> {
  _$ConfigurationStateCopyWithImpl(this._value, this._then);

  final ConfigurationState _value;
  // ignore: unused_field
  final $Res Function(ConfigurationState) _then;

  @override
  $Res call({
    Object? pushNotificationsEnabled = freezed,
    Object? timeZone = freezed,
  }) {
    return _then(_value.copyWith(
      pushNotificationsEnabled: pushNotificationsEnabled == freezed
          ? _value.pushNotificationsEnabled
          : pushNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      timeZone: timeZone == freezed
          ? _value.timeZone
          : timeZone // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$ConfigurationStateCopyWith<$Res>
    implements $ConfigurationStateCopyWith<$Res> {
  factory _$ConfigurationStateCopyWith(
          _ConfigurationState value, $Res Function(_ConfigurationState) then) =
      __$ConfigurationStateCopyWithImpl<$Res>;
  @override
  $Res call({bool pushNotificationsEnabled, String? timeZone});
}

/// @nodoc
class __$ConfigurationStateCopyWithImpl<$Res>
    extends _$ConfigurationStateCopyWithImpl<$Res>
    implements _$ConfigurationStateCopyWith<$Res> {
  __$ConfigurationStateCopyWithImpl(
      _ConfigurationState _value, $Res Function(_ConfigurationState) _then)
      : super(_value, (v) => _then(v as _ConfigurationState));

  @override
  _ConfigurationState get _value => super._value as _ConfigurationState;

  @override
  $Res call({
    Object? pushNotificationsEnabled = freezed,
    Object? timeZone = freezed,
  }) {
    return _then(_ConfigurationState(
      pushNotificationsEnabled: pushNotificationsEnabled == freezed
          ? _value.pushNotificationsEnabled
          : pushNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      timeZone: timeZone == freezed
          ? _value.timeZone
          : timeZone // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_ConfigurationState implements _ConfigurationState {
  _$_ConfigurationState({this.pushNotificationsEnabled = false, this.timeZone});

  @JsonKey(defaultValue: false)
  @override
  final bool pushNotificationsEnabled;
  @override
  final String? timeZone;

  @override
  String toString() {
    return 'ConfigurationState(pushNotificationsEnabled: $pushNotificationsEnabled, timeZone: $timeZone)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ConfigurationState &&
            (identical(
                    other.pushNotificationsEnabled, pushNotificationsEnabled) ||
                const DeepCollectionEquality().equals(
                    other.pushNotificationsEnabled,
                    pushNotificationsEnabled)) &&
            (identical(other.timeZone, timeZone) ||
                const DeepCollectionEquality()
                    .equals(other.timeZone, timeZone)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(pushNotificationsEnabled) ^
      const DeepCollectionEquality().hash(timeZone);

  @JsonKey(ignore: true)
  @override
  _$ConfigurationStateCopyWith<_ConfigurationState> get copyWith =>
      __$ConfigurationStateCopyWithImpl<_ConfigurationState>(this, _$identity);
}

abstract class _ConfigurationState implements ConfigurationState {
  factory _ConfigurationState(
      {bool pushNotificationsEnabled,
      String? timeZone}) = _$_ConfigurationState;

  @override
  bool get pushNotificationsEnabled => throw _privateConstructorUsedError;
  @override
  String? get timeZone => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ConfigurationStateCopyWith<_ConfigurationState> get copyWith =>
      throw _privateConstructorUsedError;
}
