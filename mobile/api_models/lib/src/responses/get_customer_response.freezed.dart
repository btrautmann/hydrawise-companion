// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'get_customer_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GetCustomerResponse _$GetCustomerResponseFromJson(Map<String, dynamic> json) {
  return _GetCustomerResponse.fromJson(json);
}

/// @nodoc
mixin _$GetCustomerResponse {
  @JsonKey(name: 'customer')
  Customer get customer => throw _privateConstructorUsedError;
  @JsonKey(name: 'zones')
  List<Zone> get zones => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetCustomerResponseCopyWith<GetCustomerResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetCustomerResponseCopyWith<$Res> {
  factory $GetCustomerResponseCopyWith(
          GetCustomerResponse value, $Res Function(GetCustomerResponse) then) =
      _$GetCustomerResponseCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'customer') Customer customer,
      @JsonKey(name: 'zones') List<Zone> zones});

  $CustomerCopyWith<$Res> get customer;
}

/// @nodoc
class _$GetCustomerResponseCopyWithImpl<$Res>
    implements $GetCustomerResponseCopyWith<$Res> {
  _$GetCustomerResponseCopyWithImpl(this._value, this._then);

  final GetCustomerResponse _value;
  // ignore: unused_field
  final $Res Function(GetCustomerResponse) _then;

  @override
  $Res call({
    Object? customer = freezed,
    Object? zones = freezed,
  }) {
    return _then(_value.copyWith(
      customer: customer == freezed
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as Customer,
      zones: zones == freezed
          ? _value.zones
          : zones // ignore: cast_nullable_to_non_nullable
              as List<Zone>,
    ));
  }

  @override
  $CustomerCopyWith<$Res> get customer {
    return $CustomerCopyWith<$Res>(_value.customer, (value) {
      return _then(_value.copyWith(customer: value));
    });
  }
}

/// @nodoc
abstract class _$$_GetCustomerResponseCopyWith<$Res>
    implements $GetCustomerResponseCopyWith<$Res> {
  factory _$$_GetCustomerResponseCopyWith(_$_GetCustomerResponse value,
          $Res Function(_$_GetCustomerResponse) then) =
      __$$_GetCustomerResponseCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'customer') Customer customer,
      @JsonKey(name: 'zones') List<Zone> zones});

  @override
  $CustomerCopyWith<$Res> get customer;
}

/// @nodoc
class __$$_GetCustomerResponseCopyWithImpl<$Res>
    extends _$GetCustomerResponseCopyWithImpl<$Res>
    implements _$$_GetCustomerResponseCopyWith<$Res> {
  __$$_GetCustomerResponseCopyWithImpl(_$_GetCustomerResponse _value,
      $Res Function(_$_GetCustomerResponse) _then)
      : super(_value, (v) => _then(v as _$_GetCustomerResponse));

  @override
  _$_GetCustomerResponse get _value => super._value as _$_GetCustomerResponse;

  @override
  $Res call({
    Object? customer = freezed,
    Object? zones = freezed,
  }) {
    return _then(_$_GetCustomerResponse(
      customer: customer == freezed
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as Customer,
      zones: zones == freezed
          ? _value._zones
          : zones // ignore: cast_nullable_to_non_nullable
              as List<Zone>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GetCustomerResponse implements _GetCustomerResponse {
  _$_GetCustomerResponse(
      {@JsonKey(name: 'customer') required this.customer,
      @JsonKey(name: 'zones') required final List<Zone> zones})
      : _zones = zones;

  factory _$_GetCustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$$_GetCustomerResponseFromJson(json);

  @override
  @JsonKey(name: 'customer')
  final Customer customer;
  final List<Zone> _zones;
  @override
  @JsonKey(name: 'zones')
  List<Zone> get zones {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_zones);
  }

  @override
  String toString() {
    return 'GetCustomerResponse(customer: $customer, zones: $zones)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetCustomerResponse &&
            const DeepCollectionEquality().equals(other.customer, customer) &&
            const DeepCollectionEquality().equals(other._zones, _zones));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(customer),
      const DeepCollectionEquality().hash(_zones));

  @JsonKey(ignore: true)
  @override
  _$$_GetCustomerResponseCopyWith<_$_GetCustomerResponse> get copyWith =>
      __$$_GetCustomerResponseCopyWithImpl<_$_GetCustomerResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GetCustomerResponseToJson(this);
  }
}

abstract class _GetCustomerResponse implements GetCustomerResponse {
  factory _GetCustomerResponse(
          {@JsonKey(name: 'customer') required final Customer customer,
          @JsonKey(name: 'zones') required final List<Zone> zones}) =
      _$_GetCustomerResponse;

  factory _GetCustomerResponse.fromJson(Map<String, dynamic> json) =
      _$_GetCustomerResponse.fromJson;

  @override
  @JsonKey(name: 'customer')
  Customer get customer;
  @override
  @JsonKey(name: 'zones')
  List<Zone> get zones;
  @override
  @JsonKey(ignore: true)
  _$$_GetCustomerResponseCopyWith<_$_GetCustomerResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
