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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Zone _$ZoneFromJson(Map<String, dynamic> json) {
  return _Zone.fromJson(json);
}

/// @nodoc
class _$ZoneTearOff {
  const _$ZoneTearOff();

  _Zone call(
      {@JsonKey(name: 'relay_id') required int id,
      @JsonKey(name: 'relay') required int physicalNumber,
      @JsonKey(name: 'name') required String name,
      @JsonKey(name: 'timestr') required String nextTimeOfWaterFriendly,
      @JsonKey(name: 'time') required int secondsUntilNextRun,
      @JsonKey(name: 'run') required int lengthOfNextRunTimeOrTimeRemaining}) {
    return _Zone(
      id: id,
      physicalNumber: physicalNumber,
      name: name,
      nextTimeOfWaterFriendly: nextTimeOfWaterFriendly,
      secondsUntilNextRun: secondsUntilNextRun,
      lengthOfNextRunTimeOrTimeRemaining: lengthOfNextRunTimeOrTimeRemaining,
    );
  }

  Zone fromJson(Map<String, Object?> json) {
    return Zone.fromJson(json);
  }
}

/// @nodoc
const $Zone = _$ZoneTearOff();

/// @nodoc
mixin _$Zone {
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
  $ZoneCopyWith<Zone> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ZoneCopyWith<$Res> {
  factory $ZoneCopyWith(Zone value, $Res Function(Zone) then) =
      _$ZoneCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'relay_id') int id,
      @JsonKey(name: 'relay') int physicalNumber,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'timestr') String nextTimeOfWaterFriendly,
      @JsonKey(name: 'time') int secondsUntilNextRun,
      @JsonKey(name: 'run') int lengthOfNextRunTimeOrTimeRemaining});
}

/// @nodoc
class _$ZoneCopyWithImpl<$Res> implements $ZoneCopyWith<$Res> {
  _$ZoneCopyWithImpl(this._value, this._then);

  final Zone _value;
  // ignore: unused_field
  final $Res Function(Zone) _then;

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
abstract class _$ZoneCopyWith<$Res> implements $ZoneCopyWith<$Res> {
  factory _$ZoneCopyWith(_Zone value, $Res Function(_Zone) then) =
      __$ZoneCopyWithImpl<$Res>;
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
class __$ZoneCopyWithImpl<$Res> extends _$ZoneCopyWithImpl<$Res>
    implements _$ZoneCopyWith<$Res> {
  __$ZoneCopyWithImpl(_Zone _value, $Res Function(_Zone) _then)
      : super(_value, (v) => _then(v as _Zone));

  @override
  _Zone get _value => super._value as _Zone;

  @override
  $Res call({
    Object? id = freezed,
    Object? physicalNumber = freezed,
    Object? name = freezed,
    Object? nextTimeOfWaterFriendly = freezed,
    Object? secondsUntilNextRun = freezed,
    Object? lengthOfNextRunTimeOrTimeRemaining = freezed,
  }) {
    return _then(_Zone(
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
class _$_Zone implements _Zone {
  _$_Zone(
      {@JsonKey(name: 'relay_id') required this.id,
      @JsonKey(name: 'relay') required this.physicalNumber,
      @JsonKey(name: 'name') required this.name,
      @JsonKey(name: 'timestr') required this.nextTimeOfWaterFriendly,
      @JsonKey(name: 'time') required this.secondsUntilNextRun,
      @JsonKey(name: 'run') required this.lengthOfNextRunTimeOrTimeRemaining});

  factory _$_Zone.fromJson(Map<String, dynamic> json) => _$$_ZoneFromJson(json);

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
  @override // Value will be 1 if a watering is in progress
  @JsonKey(name: 'time')
  final int secondsUntilNextRun;
  @override // If run is in progress, indicates time remaining
  @JsonKey(name: 'run')
  final int lengthOfNextRunTimeOrTimeRemaining;

  @override
  String toString() {
    return 'Zone(id: $id, physicalNumber: $physicalNumber, name: $name, nextTimeOfWaterFriendly: $nextTimeOfWaterFriendly, secondsUntilNextRun: $secondsUntilNextRun, lengthOfNextRunTimeOrTimeRemaining: $lengthOfNextRunTimeOrTimeRemaining)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Zone &&
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
  _$ZoneCopyWith<_Zone> get copyWith =>
      __$ZoneCopyWithImpl<_Zone>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ZoneToJson(this);
  }
}

abstract class _Zone implements Zone {
  factory _Zone(
      {@JsonKey(name: 'relay_id')
          required int id,
      @JsonKey(name: 'relay')
          required int physicalNumber,
      @JsonKey(name: 'name')
          required String name,
      @JsonKey(name: 'timestr')
          required String nextTimeOfWaterFriendly,
      @JsonKey(name: 'time')
          required int secondsUntilNextRun,
      @JsonKey(name: 'run')
          required int lengthOfNextRunTimeOrTimeRemaining}) = _$_Zone;

  factory _Zone.fromJson(Map<String, dynamic> json) = _$_Zone.fromJson;

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
  _$ZoneCopyWith<_Zone> get copyWith => throw _privateConstructorUsedError;
}