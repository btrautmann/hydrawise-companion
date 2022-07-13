// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'zone.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

HZone _$HZoneFromJson(Map<String, dynamic> json) {
  return _HZone.fromJson(json);
}

/// @nodoc
mixin _$HZone {
  @JsonKey(name: 'relay_id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'relay')
  int get physicalNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'timestr')
  String get nextTimeOfWaterFriendly =>
      throw _privateConstructorUsedError; // Value will be 1 if a watering is in progress
  @JsonKey(name: 'time')
  int get secondsUntilNextRun =>
      throw _privateConstructorUsedError; // If run is in progress, indicates time remaining
  @JsonKey(name: 'run')
  int get lengthOfNextRunTimeOrTimeRemaining =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HZoneCopyWith<HZone> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HZoneCopyWith<$Res> {
  factory $HZoneCopyWith(HZone value, $Res Function(HZone) then) =
      _$HZoneCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'relay_id') int id,
      @JsonKey(name: 'relay') int physicalNumber,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'timestr') String nextTimeOfWaterFriendly,
      @JsonKey(name: 'time') int secondsUntilNextRun,
      @JsonKey(name: 'run') int lengthOfNextRunTimeOrTimeRemaining});
}

/// @nodoc
class _$HZoneCopyWithImpl<$Res> implements $HZoneCopyWith<$Res> {
  _$HZoneCopyWithImpl(this._value, this._then);

  final HZone _value;
  // ignore: unused_field
  final $Res Function(HZone) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? physicalNumber = freezed,
    Object? name = freezed,
    Object? nextTimeOfWaterFriendly = freezed,
    Object? secondsUntilNextRun = freezed,
    Object? lengthOfNextRunTimeOrTimeRemaining = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      physicalNumber: physicalNumber == freezed
          ? _value.physicalNumber
          : physicalNumber // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nextTimeOfWaterFriendly: nextTimeOfWaterFriendly == freezed
          ? _value.nextTimeOfWaterFriendly
          : nextTimeOfWaterFriendly // ignore: cast_nullable_to_non_nullable
              as String,
      secondsUntilNextRun: secondsUntilNextRun == freezed
          ? _value.secondsUntilNextRun
          : secondsUntilNextRun // ignore: cast_nullable_to_non_nullable
              as int,
      lengthOfNextRunTimeOrTimeRemaining: lengthOfNextRunTimeOrTimeRemaining ==
              freezed
          ? _value.lengthOfNextRunTimeOrTimeRemaining
          : lengthOfNextRunTimeOrTimeRemaining // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_HZoneCopyWith<$Res> implements $HZoneCopyWith<$Res> {
  factory _$$_HZoneCopyWith(_$_HZone value, $Res Function(_$_HZone) then) =
      __$$_HZoneCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'relay_id') int id,
      @JsonKey(name: 'relay') int physicalNumber,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'timestr') String nextTimeOfWaterFriendly,
      @JsonKey(name: 'time') int secondsUntilNextRun,
      @JsonKey(name: 'run') int lengthOfNextRunTimeOrTimeRemaining});
}

/// @nodoc
class __$$_HZoneCopyWithImpl<$Res> extends _$HZoneCopyWithImpl<$Res>
    implements _$$_HZoneCopyWith<$Res> {
  __$$_HZoneCopyWithImpl(_$_HZone _value, $Res Function(_$_HZone) _then)
      : super(_value, (v) => _then(v as _$_HZone));

  @override
  _$_HZone get _value => super._value as _$_HZone;

  @override
  $Res call({
    Object? id = freezed,
    Object? physicalNumber = freezed,
    Object? name = freezed,
    Object? nextTimeOfWaterFriendly = freezed,
    Object? secondsUntilNextRun = freezed,
    Object? lengthOfNextRunTimeOrTimeRemaining = freezed,
  }) {
    return _then(_$_HZone(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      physicalNumber: physicalNumber == freezed
          ? _value.physicalNumber
          : physicalNumber // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nextTimeOfWaterFriendly: nextTimeOfWaterFriendly == freezed
          ? _value.nextTimeOfWaterFriendly
          : nextTimeOfWaterFriendly // ignore: cast_nullable_to_non_nullable
              as String,
      secondsUntilNextRun: secondsUntilNextRun == freezed
          ? _value.secondsUntilNextRun
          : secondsUntilNextRun // ignore: cast_nullable_to_non_nullable
              as int,
      lengthOfNextRunTimeOrTimeRemaining: lengthOfNextRunTimeOrTimeRemaining ==
              freezed
          ? _value.lengthOfNextRunTimeOrTimeRemaining
          : lengthOfNextRunTimeOrTimeRemaining // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_HZone implements _HZone {
  _$_HZone(
      {@JsonKey(name: 'relay_id') required this.id,
      @JsonKey(name: 'relay') required this.physicalNumber,
      @JsonKey(name: 'name') required this.name,
      @JsonKey(name: 'timestr') required this.nextTimeOfWaterFriendly,
      @JsonKey(name: 'time') required this.secondsUntilNextRun,
      @JsonKey(name: 'run') required this.lengthOfNextRunTimeOrTimeRemaining});

  factory _$_HZone.fromJson(Map<String, dynamic> json) =>
      _$$_HZoneFromJson(json);

  @override
  @JsonKey(name: 'relay_id')
  final int id;
  @override
  @JsonKey(name: 'relay')
  final int physicalNumber;
  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'timestr')
  final String nextTimeOfWaterFriendly;
// Value will be 1 if a watering is in progress
  @override
  @JsonKey(name: 'time')
  final int secondsUntilNextRun;
// If run is in progress, indicates time remaining
  @override
  @JsonKey(name: 'run')
  final int lengthOfNextRunTimeOrTimeRemaining;

  @override
  String toString() {
    return 'HZone(id: $id, physicalNumber: $physicalNumber, name: $name, nextTimeOfWaterFriendly: $nextTimeOfWaterFriendly, secondsUntilNextRun: $secondsUntilNextRun, lengthOfNextRunTimeOrTimeRemaining: $lengthOfNextRunTimeOrTimeRemaining)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HZone &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.physicalNumber, physicalNumber) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(
                other.nextTimeOfWaterFriendly, nextTimeOfWaterFriendly) &&
            const DeepCollectionEquality()
                .equals(other.secondsUntilNextRun, secondsUntilNextRun) &&
            const DeepCollectionEquality().equals(
                other.lengthOfNextRunTimeOrTimeRemaining,
                lengthOfNextRunTimeOrTimeRemaining));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(physicalNumber),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(nextTimeOfWaterFriendly),
      const DeepCollectionEquality().hash(secondsUntilNextRun),
      const DeepCollectionEquality().hash(lengthOfNextRunTimeOrTimeRemaining));

  @JsonKey(ignore: true)
  @override
  _$$_HZoneCopyWith<_$_HZone> get copyWith =>
      __$$_HZoneCopyWithImpl<_$_HZone>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HZoneToJson(this);
  }
}

abstract class _HZone implements HZone {
  factory _HZone(
      {@JsonKey(name: 'relay_id')
          required final int id,
      @JsonKey(name: 'relay')
          required final int physicalNumber,
      @JsonKey(name: 'name')
          required final String name,
      @JsonKey(name: 'timestr')
          required final String nextTimeOfWaterFriendly,
      @JsonKey(name: 'time')
          required final int secondsUntilNextRun,
      @JsonKey(name: 'run')
          required final int lengthOfNextRunTimeOrTimeRemaining}) = _$_HZone;

  factory _HZone.fromJson(Map<String, dynamic> json) = _$_HZone.fromJson;

  @override
  @JsonKey(name: 'relay_id')
  int get id;
  @override
  @JsonKey(name: 'relay')
  int get physicalNumber;
  @override
  @JsonKey(name: 'name')
  String get name;
  @override
  @JsonKey(name: 'timestr')
  String get nextTimeOfWaterFriendly;
  @override // Value will be 1 if a watering is in progress
  @JsonKey(name: 'time')
  int get secondsUntilNextRun;
  @override // If run is in progress, indicates time remaining
  @JsonKey(name: 'run')
  int get lengthOfNextRunTimeOrTimeRemaining;
  @override
  @JsonKey(ignore: true)
  _$$_HZoneCopyWith<_$_HZone> get copyWith =>
      throw _privateConstructorUsedError;
}
