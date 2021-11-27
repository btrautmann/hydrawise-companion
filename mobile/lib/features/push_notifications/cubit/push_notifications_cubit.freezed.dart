// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'push_notifications_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PushNotificationsStateTearOff {
  const _$PushNotificationsStateTearOff();

  _PushNotificationsState call({required bool pushNotificationsEnabled}) {
    return _PushNotificationsState(
      pushNotificationsEnabled: pushNotificationsEnabled,
    );
  }
}

/// @nodoc
const $PushNotificationsState = _$PushNotificationsStateTearOff();

/// @nodoc
mixin _$PushNotificationsState {
  bool get pushNotificationsEnabled => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PushNotificationsStateCopyWith<PushNotificationsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PushNotificationsStateCopyWith<$Res> {
  factory $PushNotificationsStateCopyWith(PushNotificationsState value,
          $Res Function(PushNotificationsState) then) =
      _$PushNotificationsStateCopyWithImpl<$Res>;
  $Res call({bool pushNotificationsEnabled});
}

/// @nodoc
class _$PushNotificationsStateCopyWithImpl<$Res>
    implements $PushNotificationsStateCopyWith<$Res> {
  _$PushNotificationsStateCopyWithImpl(this._value, this._then);

  final PushNotificationsState _value;
  // ignore: unused_field
  final $Res Function(PushNotificationsState) _then;

  @override
  $Res call({
    Object? pushNotificationsEnabled = freezed,
  }) {
    return _then(_value.copyWith(
      pushNotificationsEnabled: pushNotificationsEnabled == freezed
          ? _value.pushNotificationsEnabled
          : pushNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$PushNotificationsStateCopyWith<$Res>
    implements $PushNotificationsStateCopyWith<$Res> {
  factory _$PushNotificationsStateCopyWith(_PushNotificationsState value,
          $Res Function(_PushNotificationsState) then) =
      __$PushNotificationsStateCopyWithImpl<$Res>;
  @override
  $Res call({bool pushNotificationsEnabled});
}

/// @nodoc
class __$PushNotificationsStateCopyWithImpl<$Res>
    extends _$PushNotificationsStateCopyWithImpl<$Res>
    implements _$PushNotificationsStateCopyWith<$Res> {
  __$PushNotificationsStateCopyWithImpl(_PushNotificationsState _value,
      $Res Function(_PushNotificationsState) _then)
      : super(_value, (v) => _then(v as _PushNotificationsState));

  @override
  _PushNotificationsState get _value => super._value as _PushNotificationsState;

  @override
  $Res call({
    Object? pushNotificationsEnabled = freezed,
  }) {
    return _then(_PushNotificationsState(
      pushNotificationsEnabled: pushNotificationsEnabled == freezed
          ? _value.pushNotificationsEnabled
          : pushNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_PushNotificationsState implements _PushNotificationsState {
  _$_PushNotificationsState({required this.pushNotificationsEnabled});

  @override
  final bool pushNotificationsEnabled;

  @override
  String toString() {
    return 'PushNotificationsState(pushNotificationsEnabled: $pushNotificationsEnabled)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PushNotificationsState &&
            (identical(
                    other.pushNotificationsEnabled, pushNotificationsEnabled) ||
                const DeepCollectionEquality().equals(
                    other.pushNotificationsEnabled, pushNotificationsEnabled)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(pushNotificationsEnabled);

  @JsonKey(ignore: true)
  @override
  _$PushNotificationsStateCopyWith<_PushNotificationsState> get copyWith =>
      __$PushNotificationsStateCopyWithImpl<_PushNotificationsState>(
          this, _$identity);
}

abstract class _PushNotificationsState implements PushNotificationsState {
  factory _PushNotificationsState({required bool pushNotificationsEnabled}) =
      _$_PushNotificationsState;

  @override
  bool get pushNotificationsEnabled => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$PushNotificationsStateCopyWith<_PushNotificationsState> get copyWith =>
      throw _privateConstructorUsedError;
}
