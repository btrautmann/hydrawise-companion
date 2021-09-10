// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'customer_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CustomerDetails _$CustomerDetailsFromJson(Map<String, dynamic> json) {
  return _CustomerDetails.fromJson(json);
}

/// @nodoc
class _$CustomerDetailsTearOff {
  const _$CustomerDetailsTearOff();

  _CustomerDetails call(
      {@JsonKey(name: 'controller_id') required int controllerId,
      @JsonKey(name: 'customer_id') required int customerId}) {
    return _CustomerDetails(
      controllerId: controllerId,
      customerId: customerId,
    );
  }

  CustomerDetails fromJson(Map<String, Object> json) {
    return CustomerDetails.fromJson(json);
  }
}

/// @nodoc
const $CustomerDetails = _$CustomerDetailsTearOff();

/// @nodoc
mixin _$CustomerDetails {
  @JsonKey(name: 'controller_id')
  int get controllerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_id')
  int get customerId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomerDetailsCopyWith<CustomerDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerDetailsCopyWith<$Res> {
  factory $CustomerDetailsCopyWith(
          CustomerDetails value, $Res Function(CustomerDetails) then) =
      _$CustomerDetailsCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'controller_id') int controllerId,
      @JsonKey(name: 'customer_id') int customerId});
}

/// @nodoc
class _$CustomerDetailsCopyWithImpl<$Res>
    implements $CustomerDetailsCopyWith<$Res> {
  _$CustomerDetailsCopyWithImpl(this._value, this._then);

  final CustomerDetails _value;
  // ignore: unused_field
  final $Res Function(CustomerDetails) _then;

  @override
  $Res call({
    Object? controllerId = freezed,
    Object? customerId = freezed,
  }) {
    return _then(_value.copyWith(
      controllerId: controllerId == freezed
          ? _value.controllerId
          : controllerId // ignore: cast_nullable_to_non_nullable
              as int,
      customerId: customerId == freezed
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$CustomerDetailsCopyWith<$Res>
    implements $CustomerDetailsCopyWith<$Res> {
  factory _$CustomerDetailsCopyWith(
          _CustomerDetails value, $Res Function(_CustomerDetails) then) =
      __$CustomerDetailsCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'controller_id') int controllerId,
      @JsonKey(name: 'customer_id') int customerId});
}

/// @nodoc
class __$CustomerDetailsCopyWithImpl<$Res>
    extends _$CustomerDetailsCopyWithImpl<$Res>
    implements _$CustomerDetailsCopyWith<$Res> {
  __$CustomerDetailsCopyWithImpl(
      _CustomerDetails _value, $Res Function(_CustomerDetails) _then)
      : super(_value, (v) => _then(v as _CustomerDetails));

  @override
  _CustomerDetails get _value => super._value as _CustomerDetails;

  @override
  $Res call({
    Object? controllerId = freezed,
    Object? customerId = freezed,
  }) {
    return _then(_CustomerDetails(
      controllerId: controllerId == freezed
          ? _value.controllerId
          : controllerId // ignore: cast_nullable_to_non_nullable
              as int,
      customerId: customerId == freezed
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CustomerDetails implements _CustomerDetails {
  _$_CustomerDetails(
      {@JsonKey(name: 'controller_id') required this.controllerId,
      @JsonKey(name: 'customer_id') required this.customerId});

  factory _$_CustomerDetails.fromJson(Map<String, dynamic> json) =>
      _$_$_CustomerDetailsFromJson(json);

  @override
  @JsonKey(name: 'controller_id')
  final int controllerId;
  @override
  @JsonKey(name: 'customer_id')
  final int customerId;

  @override
  String toString() {
    return 'CustomerDetails(controllerId: $controllerId, customerId: $customerId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CustomerDetails &&
            (identical(other.controllerId, controllerId) ||
                const DeepCollectionEquality()
                    .equals(other.controllerId, controllerId)) &&
            (identical(other.customerId, customerId) ||
                const DeepCollectionEquality()
                    .equals(other.customerId, customerId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(controllerId) ^
      const DeepCollectionEquality().hash(customerId);

  @JsonKey(ignore: true)
  @override
  _$CustomerDetailsCopyWith<_CustomerDetails> get copyWith =>
      __$CustomerDetailsCopyWithImpl<_CustomerDetails>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CustomerDetailsToJson(this);
  }
}

abstract class _CustomerDetails implements CustomerDetails {
  factory _CustomerDetails(
          {@JsonKey(name: 'controller_id') required int controllerId,
          @JsonKey(name: 'customer_id') required int customerId}) =
      _$_CustomerDetails;

  factory _CustomerDetails.fromJson(Map<String, dynamic> json) =
      _$_CustomerDetails.fromJson;

  @override
  @JsonKey(name: 'controller_id')
  int get controllerId => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'customer_id')
  int get customerId => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CustomerDetailsCopyWith<_CustomerDetails> get copyWith =>
      throw _privateConstructorUsedError;
}
