// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'customer_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

HCustomerDetails _$HCustomerDetailsFromJson(Map<String, dynamic> json) {
  return _HCustomerDetails.fromJson(json);
}

/// @nodoc
mixin _$HCustomerDetails {
  @JsonKey(name: 'controller_id')
  int get activeControllerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_id')
  int get customerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'controllers')
  List<HydrawiseController> get controllers =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HCustomerDetailsCopyWith<HCustomerDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HCustomerDetailsCopyWith<$Res> {
  factory $HCustomerDetailsCopyWith(
          HCustomerDetails value, $Res Function(HCustomerDetails) then) =
      _$HCustomerDetailsCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'controller_id') int activeControllerId,
      @JsonKey(name: 'customer_id') int customerId,
      @JsonKey(name: 'controllers') List<HydrawiseController> controllers});
}

/// @nodoc
class _$HCustomerDetailsCopyWithImpl<$Res>
    implements $HCustomerDetailsCopyWith<$Res> {
  _$HCustomerDetailsCopyWithImpl(this._value, this._then);

  final HCustomerDetails _value;
  // ignore: unused_field
  final $Res Function(HCustomerDetails) _then;

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
              as List<HydrawiseController>,
    ));
  }
}

/// @nodoc
abstract class _$$_HCustomerDetailsCopyWith<$Res>
    implements $HCustomerDetailsCopyWith<$Res> {
  factory _$$_HCustomerDetailsCopyWith(
          _$_HCustomerDetails value, $Res Function(_$_HCustomerDetails) then) =
      __$$_HCustomerDetailsCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'controller_id') int activeControllerId,
      @JsonKey(name: 'customer_id') int customerId,
      @JsonKey(name: 'controllers') List<HydrawiseController> controllers});
}

/// @nodoc
class __$$_HCustomerDetailsCopyWithImpl<$Res>
    extends _$HCustomerDetailsCopyWithImpl<$Res>
    implements _$$_HCustomerDetailsCopyWith<$Res> {
  __$$_HCustomerDetailsCopyWithImpl(
      _$_HCustomerDetails _value, $Res Function(_$_HCustomerDetails) _then)
      : super(_value, (v) => _then(v as _$_HCustomerDetails));

  @override
  _$_HCustomerDetails get _value => super._value as _$_HCustomerDetails;

  @override
  $Res call({
    Object? activeControllerId = freezed,
    Object? customerId = freezed,
    Object? controllers = freezed,
  }) {
    return _then(_$_HCustomerDetails(
      activeControllerId: activeControllerId == freezed
          ? _value.activeControllerId
          : activeControllerId // ignore: cast_nullable_to_non_nullable
              as int,
      customerId: customerId == freezed
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as int,
      controllers: controllers == freezed
          ? _value._controllers
          : controllers // ignore: cast_nullable_to_non_nullable
              as List<HydrawiseController>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_HCustomerDetails implements _HCustomerDetails {
  _$_HCustomerDetails(
      {@JsonKey(name: 'controller_id')
          required this.activeControllerId,
      @JsonKey(name: 'customer_id')
          required this.customerId,
      @JsonKey(name: 'controllers')
          required final List<HydrawiseController> controllers})
      : _controllers = controllers;

  factory _$_HCustomerDetails.fromJson(Map<String, dynamic> json) =>
      _$$_HCustomerDetailsFromJson(json);

  @override
  @JsonKey(name: 'controller_id')
  final int activeControllerId;
  @override
  @JsonKey(name: 'customer_id')
  final int customerId;
  final List<HydrawiseController> _controllers;
  @override
  @JsonKey(name: 'controllers')
  List<HydrawiseController> get controllers {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_controllers);
  }

  @override
  String toString() {
    return 'HCustomerDetails(activeControllerId: $activeControllerId, customerId: $customerId, controllers: $controllers)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HCustomerDetails &&
            const DeepCollectionEquality()
                .equals(other.activeControllerId, activeControllerId) &&
            const DeepCollectionEquality()
                .equals(other.customerId, customerId) &&
            const DeepCollectionEquality()
                .equals(other._controllers, _controllers));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(activeControllerId),
      const DeepCollectionEquality().hash(customerId),
      const DeepCollectionEquality().hash(_controllers));

  @JsonKey(ignore: true)
  @override
  _$$_HCustomerDetailsCopyWith<_$_HCustomerDetails> get copyWith =>
      __$$_HCustomerDetailsCopyWithImpl<_$_HCustomerDetails>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HCustomerDetailsToJson(this);
  }
}

abstract class _HCustomerDetails implements HCustomerDetails {
  factory _HCustomerDetails(
          {@JsonKey(name: 'controller_id')
              required final int activeControllerId,
          @JsonKey(name: 'customer_id')
              required final int customerId,
          @JsonKey(name: 'controllers')
              required final List<HydrawiseController> controllers}) =
      _$_HCustomerDetails;

  factory _HCustomerDetails.fromJson(Map<String, dynamic> json) =
      _$_HCustomerDetails.fromJson;

  @override
  @JsonKey(name: 'controller_id')
  int get activeControllerId;
  @override
  @JsonKey(name: 'customer_id')
  int get customerId;
  @override
  @JsonKey(name: 'controllers')
  List<HydrawiseController> get controllers;
  @override
  @JsonKey(ignore: true)
  _$$_HCustomerDetailsCopyWith<_$_HCustomerDetails> get copyWith =>
      throw _privateConstructorUsedError;
}
