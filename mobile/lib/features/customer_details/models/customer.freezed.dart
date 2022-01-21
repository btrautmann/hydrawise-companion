// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'customer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Customer _$CustomerFromJson(Map<String, dynamic> json) {
  return _Customer.fromJson(json);
}

/// @nodoc
class _$CustomerTearOff {
  const _$CustomerTearOff();

  _Customer call(
      {@JsonKey(name: 'controller_id') required int activeControllerId,
      @JsonKey(name: 'customer_id') required int customerId,
      @JsonKey(name: 'api_key') required String apiKey,
      @JsonKey(name: 'last_status_update') required int lastStatusUpdate,
      @JsonKey(name: 'time_zone') String? timeZone = 'America/New_York'}) {
    return _Customer(
      activeControllerId: activeControllerId,
      customerId: customerId,
      apiKey: apiKey,
      lastStatusUpdate: lastStatusUpdate,
      timeZone: timeZone,
    );
  }

  Customer fromJson(Map<String, Object> json) {
    return Customer.fromJson(json);
  }
}

/// @nodoc
const $Customer = _$CustomerTearOff();

/// @nodoc
mixin _$Customer {
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
  $CustomerCopyWith<Customer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerCopyWith<$Res> {
  factory $CustomerCopyWith(Customer value, $Res Function(Customer) then) =
      _$CustomerCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'controller_id') int activeControllerId,
      @JsonKey(name: 'customer_id') int customerId,
      @JsonKey(name: 'api_key') String apiKey,
      @JsonKey(name: 'last_status_update') int lastStatusUpdate,
      @JsonKey(name: 'time_zone') String? timeZone});
}

/// @nodoc
class _$CustomerCopyWithImpl<$Res> implements $CustomerCopyWith<$Res> {
  _$CustomerCopyWithImpl(this._value, this._then);

  final Customer _value;
  // ignore: unused_field
  final $Res Function(Customer) _then;

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
abstract class _$CustomerCopyWith<$Res> implements $CustomerCopyWith<$Res> {
  factory _$CustomerCopyWith(_Customer value, $Res Function(_Customer) then) =
      __$CustomerCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'controller_id') int activeControllerId,
      @JsonKey(name: 'customer_id') int customerId,
      @JsonKey(name: 'api_key') String apiKey,
      @JsonKey(name: 'last_status_update') int lastStatusUpdate,
      @JsonKey(name: 'time_zone') String? timeZone});
}

/// @nodoc
class __$CustomerCopyWithImpl<$Res> extends _$CustomerCopyWithImpl<$Res>
    implements _$CustomerCopyWith<$Res> {
  __$CustomerCopyWithImpl(_Customer _value, $Res Function(_Customer) _then)
      : super(_value, (v) => _then(v as _Customer));

  @override
  _Customer get _value => super._value as _Customer;

  @override
  $Res call({
    Object? activeControllerId = freezed,
    Object? customerId = freezed,
    Object? apiKey = freezed,
    Object? lastStatusUpdate = freezed,
    Object? timeZone = freezed,
  }) {
    return _then(_Customer(
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
class _$_Customer implements _Customer {
  _$_Customer(
      {@JsonKey(name: 'controller_id') required this.activeControllerId,
      @JsonKey(name: 'customer_id') required this.customerId,
      @JsonKey(name: 'api_key') required this.apiKey,
      @JsonKey(name: 'last_status_update') required this.lastStatusUpdate,
      @JsonKey(name: 'time_zone') this.timeZone = 'America/New_York'});

  factory _$_Customer.fromJson(Map<String, dynamic> json) =>
      _$_$_CustomerFromJson(json);

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
    return 'Customer(activeControllerId: $activeControllerId, customerId: $customerId, apiKey: $apiKey, lastStatusUpdate: $lastStatusUpdate, timeZone: $timeZone)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Customer &&
            (identical(other.activeControllerId, activeControllerId) ||
                const DeepCollectionEquality()
                    .equals(other.activeControllerId, activeControllerId)) &&
            (identical(other.customerId, customerId) ||
                const DeepCollectionEquality()
                    .equals(other.customerId, customerId)) &&
            (identical(other.apiKey, apiKey) ||
                const DeepCollectionEquality().equals(other.apiKey, apiKey)) &&
            (identical(other.lastStatusUpdate, lastStatusUpdate) ||
                const DeepCollectionEquality()
                    .equals(other.lastStatusUpdate, lastStatusUpdate)) &&
            (identical(other.timeZone, timeZone) ||
                const DeepCollectionEquality()
                    .equals(other.timeZone, timeZone)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(activeControllerId) ^
      const DeepCollectionEquality().hash(customerId) ^
      const DeepCollectionEquality().hash(apiKey) ^
      const DeepCollectionEquality().hash(lastStatusUpdate) ^
      const DeepCollectionEquality().hash(timeZone);

  @JsonKey(ignore: true)
  @override
  _$CustomerCopyWith<_Customer> get copyWith =>
      __$CustomerCopyWithImpl<_Customer>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CustomerToJson(this);
  }
}

abstract class _Customer implements Customer {
  factory _Customer(
      {@JsonKey(name: 'controller_id') required int activeControllerId,
      @JsonKey(name: 'customer_id') required int customerId,
      @JsonKey(name: 'api_key') required String apiKey,
      @JsonKey(name: 'last_status_update') required int lastStatusUpdate,
      @JsonKey(name: 'time_zone') String? timeZone}) = _$_Customer;

  factory _Customer.fromJson(Map<String, dynamic> json) = _$_Customer.fromJson;

  @override
  @JsonKey(name: 'controller_id')
  int get activeControllerId => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'customer_id')
  int get customerId => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'api_key')
  String get apiKey => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'last_status_update')
  int get lastStatusUpdate => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'time_zone')
  String? get timeZone => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CustomerCopyWith<_Customer> get copyWith =>
      throw _privateConstructorUsedError;
}
