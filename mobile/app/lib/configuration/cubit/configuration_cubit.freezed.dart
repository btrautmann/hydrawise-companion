// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'configuration_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ConfigurationState {
  bool get pushNotificationsEnabled => throw _privateConstructorUsedError;
  String? get localTimezone => throw _privateConstructorUsedError;
  List<String> get availableTimezones => throw _privateConstructorUsedError;
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
  $Res call(
      {bool pushNotificationsEnabled,
      String? localTimezone,
      List<String> availableTimezones,
      String? timeZone});
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
    Object? localTimezone = freezed,
    Object? availableTimezones = freezed,
    Object? timeZone = freezed,
  }) {
    return _then(_value.copyWith(
      pushNotificationsEnabled: pushNotificationsEnabled == freezed
          ? _value.pushNotificationsEnabled
          : pushNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      localTimezone: localTimezone == freezed
          ? _value.localTimezone
          : localTimezone // ignore: cast_nullable_to_non_nullable
              as String?,
      availableTimezones: availableTimezones == freezed
          ? _value.availableTimezones
          : availableTimezones // ignore: cast_nullable_to_non_nullable
              as List<String>,
      timeZone: timeZone == freezed
          ? _value.timeZone
          : timeZone // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_ConfigurationStateCopyWith<$Res>
    implements $ConfigurationStateCopyWith<$Res> {
  factory _$$_ConfigurationStateCopyWith(_$_ConfigurationState value,
          $Res Function(_$_ConfigurationState) then) =
      __$$_ConfigurationStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool pushNotificationsEnabled,
      String? localTimezone,
      List<String> availableTimezones,
      String? timeZone});
}

/// @nodoc
class __$$_ConfigurationStateCopyWithImpl<$Res>
    extends _$ConfigurationStateCopyWithImpl<$Res>
    implements _$$_ConfigurationStateCopyWith<$Res> {
  __$$_ConfigurationStateCopyWithImpl(
      _$_ConfigurationState _value, $Res Function(_$_ConfigurationState) _then)
      : super(_value, (v) => _then(v as _$_ConfigurationState));

  @override
  _$_ConfigurationState get _value => super._value as _$_ConfigurationState;

  @override
  $Res call({
    Object? pushNotificationsEnabled = freezed,
    Object? localTimezone = freezed,
    Object? availableTimezones = freezed,
    Object? timeZone = freezed,
  }) {
    return _then(_$_ConfigurationState(
      pushNotificationsEnabled: pushNotificationsEnabled == freezed
          ? _value.pushNotificationsEnabled
          : pushNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      localTimezone: localTimezone == freezed
          ? _value.localTimezone
          : localTimezone // ignore: cast_nullable_to_non_nullable
              as String?,
      availableTimezones: availableTimezones == freezed
          ? _value._availableTimezones
          : availableTimezones // ignore: cast_nullable_to_non_nullable
              as List<String>,
      timeZone: timeZone == freezed
          ? _value.timeZone
          : timeZone // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_ConfigurationState implements _ConfigurationState {
  _$_ConfigurationState(
      {this.pushNotificationsEnabled = false,
      this.localTimezone = null,
      final List<String> availableTimezones = const [],
      this.timeZone})
      : _availableTimezones = availableTimezones;

  @override
  @JsonKey()
  final bool pushNotificationsEnabled;
  @override
  @JsonKey()
  final String? localTimezone;
  final List<String> _availableTimezones;
  @override
  @JsonKey()
  List<String> get availableTimezones {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableTimezones);
  }

  @override
  final String? timeZone;

  @override
  String toString() {
    return 'ConfigurationState(pushNotificationsEnabled: $pushNotificationsEnabled, localTimezone: $localTimezone, availableTimezones: $availableTimezones, timeZone: $timeZone)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ConfigurationState &&
            const DeepCollectionEquality().equals(
                other.pushNotificationsEnabled, pushNotificationsEnabled) &&
            const DeepCollectionEquality()
                .equals(other.localTimezone, localTimezone) &&
            const DeepCollectionEquality()
                .equals(other._availableTimezones, _availableTimezones) &&
            const DeepCollectionEquality().equals(other.timeZone, timeZone));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(pushNotificationsEnabled),
      const DeepCollectionEquality().hash(localTimezone),
      const DeepCollectionEquality().hash(_availableTimezones),
      const DeepCollectionEquality().hash(timeZone));

  @JsonKey(ignore: true)
  @override
  _$$_ConfigurationStateCopyWith<_$_ConfigurationState> get copyWith =>
      __$$_ConfigurationStateCopyWithImpl<_$_ConfigurationState>(
          this, _$identity);
}

abstract class _ConfigurationState implements ConfigurationState {
  factory _ConfigurationState(
      {final bool pushNotificationsEnabled,
      final String? localTimezone,
      final List<String> availableTimezones,
      final String? timeZone}) = _$_ConfigurationState;

  @override
  bool get pushNotificationsEnabled;
  @override
  String? get localTimezone;
  @override
  List<String> get availableTimezones;
  @override
  String? get timeZone;
  @override
  @JsonKey(ignore: true)
  _$$_ConfigurationStateCopyWith<_$_ConfigurationState> get copyWith =>
      throw _privateConstructorUsedError;
}
