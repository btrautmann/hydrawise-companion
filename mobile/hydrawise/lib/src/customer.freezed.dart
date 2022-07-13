// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'customer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

HCustomer _$HCustomerFromJson(Map<String, dynamic> json) {
  return _HCustomer.fromJson(json);
}

/// @nodoc
mixin _$HCustomer {
  @JsonKey(name: 'controller_id')
  int get activeControllerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_id')
  int get customerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'api_key')
  String get apiKey => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_status_update')
  int get lastStatusUpdate => throw _privateConstructorUsedError;
  @JsonKey(name: 'time_zone')
  String? get timeZone => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HCustomerCopyWith<HCustomer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HCustomerCopyWith<$Res> {
  factory $HCustomerCopyWith(HCustomer value, $Res Function(HCustomer) then) =
      _$HCustomerCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'controller_id') int activeControllerId,
      @JsonKey(name: 'customer_id') int customerId,
      @JsonKey(name: 'api_key') String apiKey,
      @JsonKey(name: 'last_status_update') int lastStatusUpdate,
      @JsonKey(name: 'time_zone') String? timeZone});
}

/// @nodoc
class _$HCustomerCopyWithImpl<$Res> implements $HCustomerCopyWith<$Res> {
  _$HCustomerCopyWithImpl(this._value, this._then);

  final HCustomer _value;
  // ignore: unused_field
  final $Res Function(HCustomer) _then;

  @override
  $Res call({
    Object? activeControllerId = freezed,
    Object? customerId = freezed,
    Object? apiKey = freezed,
    Object? lastStatusUpdate = freezed,
    Object? timeZone = freezed,
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
      apiKey: apiKey == freezed
          ? _value.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String,
      lastStatusUpdate: lastStatusUpdate == freezed
          ? _value.lastStatusUpdate
          : lastStatusUpdate // ignore: cast_nullable_to_non_nullable
              as int,
      timeZone: timeZone == freezed
          ? _value.timeZone
          : timeZone // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_HCustomerCopyWith<$Res> implements $HCustomerCopyWith<$Res> {
  factory _$$_HCustomerCopyWith(
          _$_HCustomer value, $Res Function(_$_HCustomer) then) =
      __$$_HCustomerCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'controller_id') int activeControllerId,
      @JsonKey(name: 'customer_id') int customerId,
      @JsonKey(name: 'api_key') String apiKey,
      @JsonKey(name: 'last_status_update') int lastStatusUpdate,
      @JsonKey(name: 'time_zone') String? timeZone});
}

/// @nodoc
class __$$_HCustomerCopyWithImpl<$Res> extends _$HCustomerCopyWithImpl<$Res>
    implements _$$_HCustomerCopyWith<$Res> {
  __$$_HCustomerCopyWithImpl(
      _$_HCustomer _value, $Res Function(_$_HCustomer) _then)
      : super(_value, (v) => _then(v as _$_HCustomer));

  @override
  _$_HCustomer get _value => super._value as _$_HCustomer;

  @override
  $Res call({
    Object? activeControllerId = freezed,
    Object? customerId = freezed,
    Object? apiKey = freezed,
    Object? lastStatusUpdate = freezed,
    Object? timeZone = freezed,
  }) {
    return _then(_$_HCustomer(
      activeControllerId: activeControllerId == freezed
          ? _value.activeControllerId
          : activeControllerId // ignore: cast_nullable_to_non_nullable
              as int,
      customerId: customerId == freezed
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as int,
      apiKey: apiKey == freezed
          ? _value.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String,
      lastStatusUpdate: lastStatusUpdate == freezed
          ? _value.lastStatusUpdate
          : lastStatusUpdate // ignore: cast_nullable_to_non_nullable
              as int,
      timeZone: timeZone == freezed
          ? _value.timeZone
          : timeZone // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_HCustomer implements _HCustomer {
  _$_HCustomer(
      {@JsonKey(name: 'controller_id') required this.activeControllerId,
      @JsonKey(name: 'customer_id') required this.customerId,
      @JsonKey(name: 'api_key') required this.apiKey,
      @JsonKey(name: 'last_status_update') required this.lastStatusUpdate,
      @JsonKey(name: 'time_zone') this.timeZone = 'America/New_York'});

  factory _$_HCustomer.fromJson(Map<String, dynamic> json) =>
      _$$_HCustomerFromJson(json);

  @override
  @JsonKey(name: 'controller_id')
  final int activeControllerId;
  @override
  @JsonKey(name: 'customer_id')
  final int customerId;
  @override
  @JsonKey(name: 'api_key')
  final String apiKey;
  @override
  @JsonKey(name: 'last_status_update')
  final int lastStatusUpdate;
  @override
  @JsonKey(name: 'time_zone')
  final String? timeZone;

  @override
  String toString() {
    return 'HCustomer(activeControllerId: $activeControllerId, customerId: $customerId, apiKey: $apiKey, lastStatusUpdate: $lastStatusUpdate, timeZone: $timeZone)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HCustomer &&
            const DeepCollectionEquality()
                .equals(other.activeControllerId, activeControllerId) &&
            const DeepCollectionEquality()
                .equals(other.customerId, customerId) &&
            const DeepCollectionEquality().equals(other.apiKey, apiKey) &&
            const DeepCollectionEquality()
                .equals(other.lastStatusUpdate, lastStatusUpdate) &&
            const DeepCollectionEquality().equals(other.timeZone, timeZone));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(activeControllerId),
      const DeepCollectionEquality().hash(customerId),
      const DeepCollectionEquality().hash(apiKey),
      const DeepCollectionEquality().hash(lastStatusUpdate),
      const DeepCollectionEquality().hash(timeZone));

  @JsonKey(ignore: true)
  @override
  _$$_HCustomerCopyWith<_$_HCustomer> get copyWith =>
      __$$_HCustomerCopyWithImpl<_$_HCustomer>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HCustomerToJson(this);
  }
}

abstract class _HCustomer implements HCustomer {
  factory _HCustomer(
      {@JsonKey(name: 'controller_id') required final int activeControllerId,
      @JsonKey(name: 'customer_id') required final int customerId,
      @JsonKey(name: 'api_key') required final String apiKey,
      @JsonKey(name: 'last_status_update') required final int lastStatusUpdate,
      @JsonKey(name: 'time_zone') final String? timeZone}) = _$_HCustomer;

  factory _HCustomer.fromJson(Map<String, dynamic> json) =
      _$_HCustomer.fromJson;

  @override
  @JsonKey(name: 'controller_id')
  int get activeControllerId;
  @override
  @JsonKey(name: 'customer_id')
  int get customerId;
  @override
  @JsonKey(name: 'api_key')
  String get apiKey;
  @override
  @JsonKey(name: 'last_status_update')
  int get lastStatusUpdate;
  @override
  @JsonKey(name: 'time_zone')
  String? get timeZone;
  @override
  @JsonKey(ignore: true)
  _$$_HCustomerCopyWith<_$_HCustomer> get copyWith =>
      throw _privateConstructorUsedError;
}
