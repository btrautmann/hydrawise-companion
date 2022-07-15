// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'developer_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DeveloperState {
  Map<String, dynamic> get storage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DeveloperStateCopyWith<DeveloperState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeveloperStateCopyWith<$Res> {
  factory $DeveloperStateCopyWith(
          DeveloperState value, $Res Function(DeveloperState) then) =
      _$DeveloperStateCopyWithImpl<$Res>;
  $Res call({Map<String, dynamic> storage});
}

/// @nodoc
class _$DeveloperStateCopyWithImpl<$Res>
    implements $DeveloperStateCopyWith<$Res> {
  _$DeveloperStateCopyWithImpl(this._value, this._then);

  final DeveloperState _value;
  // ignore: unused_field
  final $Res Function(DeveloperState) _then;

  @override
  $Res call({
    Object? storage = freezed,
  }) {
    return _then(_value.copyWith(
      storage: storage == freezed
          ? _value.storage
          : storage // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
abstract class _$$_DeveloperStateCopyWith<$Res>
    implements $DeveloperStateCopyWith<$Res> {
  factory _$$_DeveloperStateCopyWith(
          _$_DeveloperState value, $Res Function(_$_DeveloperState) then) =
      __$$_DeveloperStateCopyWithImpl<$Res>;
  @override
  $Res call({Map<String, dynamic> storage});
}

/// @nodoc
class __$$_DeveloperStateCopyWithImpl<$Res>
    extends _$DeveloperStateCopyWithImpl<$Res>
    implements _$$_DeveloperStateCopyWith<$Res> {
  __$$_DeveloperStateCopyWithImpl(
      _$_DeveloperState _value, $Res Function(_$_DeveloperState) _then)
      : super(_value, (v) => _then(v as _$_DeveloperState));

  @override
  _$_DeveloperState get _value => super._value as _$_DeveloperState;

  @override
  $Res call({
    Object? storage = freezed,
  }) {
    return _then(_$_DeveloperState(
      storage: storage == freezed
          ? _value._storage
          : storage // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

class _$_DeveloperState implements _DeveloperState {
  _$_DeveloperState({required final Map<String, dynamic> storage})
      : _storage = storage;

  final Map<String, dynamic> _storage;
  @override
  Map<String, dynamic> get storage {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_storage);
  }

  @override
  String toString() {
    return 'DeveloperState(storage: $storage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DeveloperState &&
            const DeepCollectionEquality().equals(other._storage, _storage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_storage));

  @JsonKey(ignore: true)
  @override
  _$$_DeveloperStateCopyWith<_$_DeveloperState> get copyWith =>
      __$$_DeveloperStateCopyWithImpl<_$_DeveloperState>(this, _$identity);
}

abstract class _DeveloperState implements DeveloperState {
  factory _DeveloperState({required final Map<String, dynamic> storage}) =
      _$_DeveloperState;

  @override
  Map<String, dynamic> get storage;
  @override
  @JsonKey(ignore: true)
  _$$_DeveloperStateCopyWith<_$_DeveloperState> get copyWith =>
      throw _privateConstructorUsedError;
}
