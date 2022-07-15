// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'customer_details_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CustomerDetailsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(Customer customerDetails, List<Zone> zones)
        complete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Customer customerDetails, List<Zone> zones)? complete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Customer customerDetails, List<Zone> zones)? complete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Complete value) complete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Complete value)? complete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Complete value)? complete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerDetailsStateCopyWith<$Res> {
  factory $CustomerDetailsStateCopyWith(CustomerDetailsState value,
          $Res Function(CustomerDetailsState) then) =
      _$CustomerDetailsStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$CustomerDetailsStateCopyWithImpl<$Res>
    implements $CustomerDetailsStateCopyWith<$Res> {
  _$CustomerDetailsStateCopyWithImpl(this._value, this._then);

  final CustomerDetailsState _value;
  // ignore: unused_field
  final $Res Function(CustomerDetailsState) _then;
}

/// @nodoc
abstract class _$$_LoadingCopyWith<$Res> {
  factory _$$_LoadingCopyWith(
          _$_Loading value, $Res Function(_$_Loading) then) =
      __$$_LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_LoadingCopyWithImpl<$Res>
    extends _$CustomerDetailsStateCopyWithImpl<$Res>
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
    return 'CustomerDetailsState.loading()';
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
    required TResult Function() loading,
    required TResult Function(Customer customerDetails, List<Zone> zones)
        complete,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Customer customerDetails, List<Zone> zones)? complete,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Customer customerDetails, List<Zone> zones)? complete,
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
    required TResult Function(_Loading value) loading,
    required TResult Function(_Complete value) complete,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Complete value)? complete,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Complete value)? complete,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements CustomerDetailsState {
  factory _Loading() = _$_Loading;
}

/// @nodoc
abstract class _$$_CompleteCopyWith<$Res> {
  factory _$$_CompleteCopyWith(
          _$_Complete value, $Res Function(_$_Complete) then) =
      __$$_CompleteCopyWithImpl<$Res>;
  $Res call({Customer customerDetails, List<Zone> zones});

  $CustomerCopyWith<$Res> get customerDetails;
}

/// @nodoc
class __$$_CompleteCopyWithImpl<$Res>
    extends _$CustomerDetailsStateCopyWithImpl<$Res>
    implements _$$_CompleteCopyWith<$Res> {
  __$$_CompleteCopyWithImpl(
      _$_Complete _value, $Res Function(_$_Complete) _then)
      : super(_value, (v) => _then(v as _$_Complete));

  @override
  _$_Complete get _value => super._value as _$_Complete;

  @override
  $Res call({
    Object? customerDetails = freezed,
    Object? zones = freezed,
  }) {
    return _then(_$_Complete(
      customerDetails: customerDetails == freezed
          ? _value.customerDetails
          : customerDetails // ignore: cast_nullable_to_non_nullable
              as Customer,
      zones: zones == freezed
          ? _value._zones
          : zones // ignore: cast_nullable_to_non_nullable
              as List<Zone>,
    ));
  }

  @override
  $CustomerCopyWith<$Res> get customerDetails {
    return $CustomerCopyWith<$Res>(_value.customerDetails, (value) {
      return _then(_value.copyWith(customerDetails: value));
    });
  }
}

/// @nodoc

class _$_Complete implements _Complete {
  _$_Complete({required this.customerDetails, required final List<Zone> zones})
      : _zones = zones;

  @override
  final Customer customerDetails;
  final List<Zone> _zones;
  @override
  List<Zone> get zones {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_zones);
  }

  @override
  String toString() {
    return 'CustomerDetailsState.complete(customerDetails: $customerDetails, zones: $zones)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Complete &&
            const DeepCollectionEquality()
                .equals(other.customerDetails, customerDetails) &&
            const DeepCollectionEquality().equals(other._zones, _zones));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(customerDetails),
      const DeepCollectionEquality().hash(_zones));

  @JsonKey(ignore: true)
  @override
  _$$_CompleteCopyWith<_$_Complete> get copyWith =>
      __$$_CompleteCopyWithImpl<_$_Complete>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(Customer customerDetails, List<Zone> zones)
        complete,
  }) {
    return complete(customerDetails, zones);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Customer customerDetails, List<Zone> zones)? complete,
  }) {
    return complete?.call(customerDetails, zones);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Customer customerDetails, List<Zone> zones)? complete,
    required TResult orElse(),
  }) {
    if (complete != null) {
      return complete(customerDetails, zones);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Complete value) complete,
  }) {
    return complete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Complete value)? complete,
  }) {
    return complete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Complete value)? complete,
    required TResult orElse(),
  }) {
    if (complete != null) {
      return complete(this);
    }
    return orElse();
  }
}

abstract class _Complete implements CustomerDetailsState {
  factory _Complete(
      {required final Customer customerDetails,
      required final List<Zone> zones}) = _$_Complete;

  Customer get customerDetails;
  List<Zone> get zones;
  @JsonKey(ignore: true)
  _$$_CompleteCopyWith<_$_Complete> get copyWith =>
      throw _privateConstructorUsedError;
}
