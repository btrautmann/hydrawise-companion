// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'customer_details_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$CustomerDetailsStateTearOff {
  const _$CustomerDetailsStateTearOff();

  _Loading loading() {
    return _Loading();
  }

  _Complete complete(
      {required CustomerDetails customerDetails,
      required CustomerStatus customerStatus}) {
    return _Complete(
      customerDetails: customerDetails,
      customerStatus: customerStatus,
    );
  }
}

/// @nodoc
const $CustomerDetailsState = _$CustomerDetailsStateTearOff();

/// @nodoc
mixin _$CustomerDetailsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            CustomerDetails customerDetails, CustomerStatus customerStatus)
        complete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            CustomerDetails customerDetails, CustomerStatus customerStatus)?
        complete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            CustomerDetails customerDetails, CustomerStatus customerStatus)?
        complete,
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
abstract class _$LoadingCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) then) =
      __$LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$LoadingCopyWithImpl<$Res>
    extends _$CustomerDetailsStateCopyWithImpl<$Res>
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
    return 'CustomerDetailsState.loading()';
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
    required TResult Function() loading,
    required TResult Function(
            CustomerDetails customerDetails, CustomerStatus customerStatus)
        complete,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            CustomerDetails customerDetails, CustomerStatus customerStatus)?
        complete,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            CustomerDetails customerDetails, CustomerStatus customerStatus)?
        complete,
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
abstract class _$CompleteCopyWith<$Res> {
  factory _$CompleteCopyWith(_Complete value, $Res Function(_Complete) then) =
      __$CompleteCopyWithImpl<$Res>;
  $Res call({CustomerDetails customerDetails, CustomerStatus customerStatus});

  $CustomerDetailsCopyWith<$Res> get customerDetails;
  $CustomerStatusCopyWith<$Res> get customerStatus;
}

/// @nodoc
class __$CompleteCopyWithImpl<$Res>
    extends _$CustomerDetailsStateCopyWithImpl<$Res>
    implements _$CompleteCopyWith<$Res> {
  __$CompleteCopyWithImpl(_Complete _value, $Res Function(_Complete) _then)
      : super(_value, (v) => _then(v as _Complete));

  @override
  _Complete get _value => super._value as _Complete;

  @override
  $Res call({
    Object? customerDetails = freezed,
    Object? customerStatus = freezed,
  }) {
    return _then(_Complete(
      customerDetails: customerDetails == freezed
          ? _value.customerDetails
          : customerDetails // ignore: cast_nullable_to_non_nullable
              as CustomerDetails,
      customerStatus: customerStatus == freezed
          ? _value.customerStatus
          : customerStatus // ignore: cast_nullable_to_non_nullable
              as CustomerStatus,
    ));
  }

  @override
  $CustomerDetailsCopyWith<$Res> get customerDetails {
    return $CustomerDetailsCopyWith<$Res>(_value.customerDetails, (value) {
      return _then(_value.copyWith(customerDetails: value));
    });
  }

  @override
  $CustomerStatusCopyWith<$Res> get customerStatus {
    return $CustomerStatusCopyWith<$Res>(_value.customerStatus, (value) {
      return _then(_value.copyWith(customerStatus: value));
    });
  }
}

/// @nodoc

class _$_Complete implements _Complete {
  _$_Complete({required this.customerDetails, required this.customerStatus});

  @override
  final CustomerDetails customerDetails;
  @override
  final CustomerStatus customerStatus;

  @override
  String toString() {
    return 'CustomerDetailsState.complete(customerDetails: $customerDetails, customerStatus: $customerStatus)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Complete &&
            (identical(other.customerDetails, customerDetails) ||
                const DeepCollectionEquality()
                    .equals(other.customerDetails, customerDetails)) &&
            (identical(other.customerStatus, customerStatus) ||
                const DeepCollectionEquality()
                    .equals(other.customerStatus, customerStatus)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(customerDetails) ^
      const DeepCollectionEquality().hash(customerStatus);

  @JsonKey(ignore: true)
  @override
  _$CompleteCopyWith<_Complete> get copyWith =>
      __$CompleteCopyWithImpl<_Complete>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            CustomerDetails customerDetails, CustomerStatus customerStatus)
        complete,
  }) {
    return complete(customerDetails, customerStatus);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            CustomerDetails customerDetails, CustomerStatus customerStatus)?
        complete,
  }) {
    return complete?.call(customerDetails, customerStatus);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            CustomerDetails customerDetails, CustomerStatus customerStatus)?
        complete,
    required TResult orElse(),
  }) {
    if (complete != null) {
      return complete(customerDetails, customerStatus);
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
      {required CustomerDetails customerDetails,
      required CustomerStatus customerStatus}) = _$_Complete;

  CustomerDetails get customerDetails => throw _privateConstructorUsedError;
  CustomerStatus get customerStatus => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$CompleteCopyWith<_Complete> get copyWith =>
      throw _privateConstructorUsedError;
}
