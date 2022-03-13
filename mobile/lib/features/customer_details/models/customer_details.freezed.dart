// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
      {@JsonKey(name: 'controller_id') required int activeControllerId,
      @JsonKey(name: 'customer_id') required int customerId,
      @JsonKey(name: 'controllers') required List<Controller> controllers}) {
    return _CustomerDetails(
      activeControllerId: activeControllerId,
      customerId: customerId,
      controllers: controllers,
    );
  }

  CustomerDetails fromJson(Map<String, Object?> json) {
    return CustomerDetails.fromJson(json);
  }
}

/// @nodoc
const $CustomerDetails = _$CustomerDetailsTearOff();

/// @nodoc
mixin _$CustomerDetails {
  @JsonKey(name: 'controller_id')
  int get activeControllerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_id')
  int get customerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'controllers')
  List<Controller> get controllers => throw _privateConstructorUsedError;

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
      {@JsonKey(name: 'controller_id') int activeControllerId,
      @JsonKey(name: 'customer_id') int customerId,
      @JsonKey(name: 'controllers') List<Controller> controllers});
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
    Object? activeControllerId = freezed,
    Object? customerId = freezed,
    Object? controllers = freezed,
  }) {
    return _then(_value.copyWith(
      activeControllerId: activeControllerId == freezed
          ? _value.activeControllerId
          : activeControllerId // ignore: cast_nullable_to_non_nullable
              as int,
      customerId: customerId == freezed
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as int,
      controllers: controllers == freezed
          ? _value.controllers
          : controllers // ignore: cast_nullable_to_non_nullable
              as List<Controller>,
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
      {@JsonKey(name: 'controller_id') int activeControllerId,
      @JsonKey(name: 'customer_id') int customerId,
      @JsonKey(name: 'controllers') List<Controller> controllers});
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
    Object? activeControllerId = freezed,
    Object? customerId = freezed,
    Object? controllers = freezed,
  }) {
    return _then(_CustomerDetails(
      activeControllerId: activeControllerId == freezed
          ? _value.activeControllerId
          : activeControllerId // ignore: cast_nullable_to_non_nullable
              as int,
      customerId: customerId == freezed
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as int,
      controllers: controllers == freezed
          ? _value.controllers
          : controllers // ignore: cast_nullable_to_non_nullable
              as List<Controller>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CustomerDetails implements _CustomerDetails {
  _$_CustomerDetails(
      {@JsonKey(name: 'controller_id') required this.activeControllerId,
      @JsonKey(name: 'customer_id') required this.customerId,
      @JsonKey(name: 'controllers') required this.controllers});

  factory _$_CustomerDetails.fromJson(Map<String, dynamic> json) =>
      _$$_CustomerDetailsFromJson(json);

  @override
  @JsonKey(name: 'controller_id')
  final int activeControllerId;
  @override
  @JsonKey(name: 'customer_id')
  final int customerId;
  @override
  @JsonKey(name: 'controllers')
  final List<Controller> controllers;

  @override
  String toString() {
    return 'CustomerDetails(activeControllerId: $activeControllerId, customerId: $customerId, controllers: $controllers)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CustomerDetails &&
            const DeepCollectionEquality()
                .equals(other.activeControllerId, activeControllerId) &&
            const DeepCollectionEquality()
                .equals(other.customerId, customerId) &&
            const DeepCollectionEquality()
                .equals(other.controllers, controllers));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(activeControllerId),
      const DeepCollectionEquality().hash(customerId),
      const DeepCollectionEquality().hash(controllers));

  @JsonKey(ignore: true)
  @override
  _$CustomerDetailsCopyWith<_CustomerDetails> get copyWith =>
      __$CustomerDetailsCopyWithImpl<_CustomerDetails>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CustomerDetailsToJson(this);
  }
}

abstract class _CustomerDetails implements CustomerDetails {
  factory _CustomerDetails(
      {@JsonKey(name: 'controller_id')
          required int activeControllerId,
      @JsonKey(name: 'customer_id')
          required int customerId,
      @JsonKey(name: 'controllers')
          required List<Controller> controllers}) = _$_CustomerDetails;

  factory _CustomerDetails.fromJson(Map<String, dynamic> json) =
      _$_CustomerDetails.fromJson;

  @override
  @JsonKey(name: 'controller_id')
  int get activeControllerId;
  @override
  @JsonKey(name: 'customer_id')
  int get customerId;
  @override
  @JsonKey(name: 'controllers')
  List<Controller> get controllers;
  @override
  @JsonKey(ignore: true)
  _$CustomerDetailsCopyWith<_CustomerDetails> get copyWith =>
      throw _privateConstructorUsedError;
}
