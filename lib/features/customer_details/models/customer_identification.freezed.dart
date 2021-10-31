// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'customer_identification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CustomerIdentification _$CustomerIdentificationFromJson(
    Map<String, dynamic> json) {
  return _CustomerIdentification.fromJson(json);
}

/// @nodoc
class _$CustomerIdentificationTearOff {
  const _$CustomerIdentificationTearOff();

  _CustomerIdentification call(
      {@JsonKey(name: 'controller_id') required int activeControllerId,
      @JsonKey(name: 'customer_id') required int customerId,
      @JsonKey(name: 'api_key') required String apiKey,
      @JsonKey(name: 'last_status_update') required int lastStatusUpdate}) {
    return _CustomerIdentification(
      activeControllerId: activeControllerId,
      customerId: customerId,
      apiKey: apiKey,
      lastStatusUpdate: lastStatusUpdate,
    );
  }

  CustomerIdentification fromJson(Map<String, Object> json) {
    return CustomerIdentification.fromJson(json);
  }
}

/// @nodoc
const $CustomerIdentification = _$CustomerIdentificationTearOff();

/// @nodoc
mixin _$CustomerIdentification {
  @JsonKey(name: 'controller_id')
  int get activeControllerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_id')
  int get customerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'api_key')
  String get apiKey => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_status_update')
  int get lastStatusUpdate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomerIdentificationCopyWith<CustomerIdentification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerIdentificationCopyWith<$Res> {
  factory $CustomerIdentificationCopyWith(CustomerIdentification value,
          $Res Function(CustomerIdentification) then) =
      _$CustomerIdentificationCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'controller_id') int activeControllerId,
      @JsonKey(name: 'customer_id') int customerId,
      @JsonKey(name: 'api_key') String apiKey,
      @JsonKey(name: 'last_status_update') int lastStatusUpdate});
}

/// @nodoc
class _$CustomerIdentificationCopyWithImpl<$Res>
    implements $CustomerIdentificationCopyWith<$Res> {
  _$CustomerIdentificationCopyWithImpl(this._value, this._then);

  final CustomerIdentification _value;
  // ignore: unused_field
  final $Res Function(CustomerIdentification) _then;

  @override
  $Res call({
    Object? activeControllerId = freezed,
    Object? customerId = freezed,
    Object? apiKey = freezed,
    Object? lastStatusUpdate = freezed,
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
    ));
  }
}

/// @nodoc
abstract class _$CustomerIdentificationCopyWith<$Res>
    implements $CustomerIdentificationCopyWith<$Res> {
  factory _$CustomerIdentificationCopyWith(_CustomerIdentification value,
          $Res Function(_CustomerIdentification) then) =
      __$CustomerIdentificationCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'controller_id') int activeControllerId,
      @JsonKey(name: 'customer_id') int customerId,
      @JsonKey(name: 'api_key') String apiKey,
      @JsonKey(name: 'last_status_update') int lastStatusUpdate});
}

/// @nodoc
class __$CustomerIdentificationCopyWithImpl<$Res>
    extends _$CustomerIdentificationCopyWithImpl<$Res>
    implements _$CustomerIdentificationCopyWith<$Res> {
  __$CustomerIdentificationCopyWithImpl(_CustomerIdentification _value,
      $Res Function(_CustomerIdentification) _then)
      : super(_value, (v) => _then(v as _CustomerIdentification));

  @override
  _CustomerIdentification get _value => super._value as _CustomerIdentification;

  @override
  $Res call({
    Object? activeControllerId = freezed,
    Object? customerId = freezed,
    Object? apiKey = freezed,
    Object? lastStatusUpdate = freezed,
  }) {
    return _then(_CustomerIdentification(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CustomerIdentification implements _CustomerIdentification {
  _$_CustomerIdentification(
      {@JsonKey(name: 'controller_id') required this.activeControllerId,
      @JsonKey(name: 'customer_id') required this.customerId,
      @JsonKey(name: 'api_key') required this.apiKey,
      @JsonKey(name: 'last_status_update') required this.lastStatusUpdate});

  factory _$_CustomerIdentification.fromJson(Map<String, dynamic> json) =>
      _$_$_CustomerIdentificationFromJson(json);

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
  String toString() {
    return 'CustomerIdentification(activeControllerId: $activeControllerId, customerId: $customerId, apiKey: $apiKey, lastStatusUpdate: $lastStatusUpdate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CustomerIdentification &&
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
                    .equals(other.lastStatusUpdate, lastStatusUpdate)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(activeControllerId) ^
      const DeepCollectionEquality().hash(customerId) ^
      const DeepCollectionEquality().hash(apiKey) ^
      const DeepCollectionEquality().hash(lastStatusUpdate);

  @JsonKey(ignore: true)
  @override
  _$CustomerIdentificationCopyWith<_CustomerIdentification> get copyWith =>
      __$CustomerIdentificationCopyWithImpl<_CustomerIdentification>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CustomerIdentificationToJson(this);
  }
}

abstract class _CustomerIdentification implements CustomerIdentification {
  factory _CustomerIdentification(
          {@JsonKey(name: 'controller_id') required int activeControllerId,
          @JsonKey(name: 'customer_id') required int customerId,
          @JsonKey(name: 'api_key') required String apiKey,
          @JsonKey(name: 'last_status_update') required int lastStatusUpdate}) =
      _$_CustomerIdentification;

  factory _CustomerIdentification.fromJson(Map<String, dynamic> json) =
      _$_CustomerIdentification.fromJson;

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
  @JsonKey(ignore: true)
  _$CustomerIdentificationCopyWith<_CustomerIdentification> get copyWith =>
      throw _privateConstructorUsedError;
}
