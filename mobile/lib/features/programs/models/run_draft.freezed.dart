// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'run_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$RunDraftTearOff {
  const _$RunDraftTearOff();

  _RunCreation creation(
      {required TimeOfDay timeOfDay,
      required List<int> zoneIds,
      required Duration duration}) {
    return _RunCreation(
      timeOfDay: timeOfDay,
      zoneIds: zoneIds,
      duration: duration,
    );
  }

  _RunModification modification(
      {required TimeOfDay timeOfDay,
      required List<int> zoneIds,
      required Duration duration}) {
    return _RunModification(
      timeOfDay: timeOfDay,
      zoneIds: zoneIds,
      duration: duration,
    );
  }
}

/// @nodoc
const $RunDraft = _$RunDraftTearOff();

/// @nodoc
mixin _$RunDraft {
  TimeOfDay get timeOfDay => throw _privateConstructorUsedError;
  List<int> get zoneIds => throw _privateConstructorUsedError;
  Duration get duration => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            TimeOfDay timeOfDay, List<int> zoneIds, Duration duration)
        creation,
    required TResult Function(
            TimeOfDay timeOfDay, List<int> zoneIds, Duration duration)
        modification,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(TimeOfDay timeOfDay, List<int> zoneIds, Duration duration)?
        creation,
    TResult Function(TimeOfDay timeOfDay, List<int> zoneIds, Duration duration)?
        modification,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TimeOfDay timeOfDay, List<int> zoneIds, Duration duration)?
        creation,
    TResult Function(TimeOfDay timeOfDay, List<int> zoneIds, Duration duration)?
        modification,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RunCreation value) creation,
    required TResult Function(_RunModification value) modification,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_RunCreation value)? creation,
    TResult Function(_RunModification value)? modification,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RunCreation value)? creation,
    TResult Function(_RunModification value)? modification,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RunDraftCopyWith<RunDraft> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RunDraftCopyWith<$Res> {
  factory $RunDraftCopyWith(RunDraft value, $Res Function(RunDraft) then) =
      _$RunDraftCopyWithImpl<$Res>;
  $Res call({TimeOfDay timeOfDay, List<int> zoneIds, Duration duration});
}

/// @nodoc
class _$RunDraftCopyWithImpl<$Res> implements $RunDraftCopyWith<$Res> {
  _$RunDraftCopyWithImpl(this._value, this._then);

  final RunDraft _value;
  // ignore: unused_field
  final $Res Function(RunDraft) _then;

  @override
  $Res call({
    Object? timeOfDay = freezed,
    Object? zoneIds = freezed,
    Object? duration = freezed,
  }) {
    return _then(_value.copyWith(
      timeOfDay: timeOfDay == freezed
          ? _value.timeOfDay
          : timeOfDay // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      zoneIds: zoneIds == freezed
          ? _value.zoneIds
          : zoneIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc
abstract class _$RunCreationCopyWith<$Res> implements $RunDraftCopyWith<$Res> {
  factory _$RunCreationCopyWith(
          _RunCreation value, $Res Function(_RunCreation) then) =
      __$RunCreationCopyWithImpl<$Res>;
  @override
  $Res call({TimeOfDay timeOfDay, List<int> zoneIds, Duration duration});
}

/// @nodoc
class __$RunCreationCopyWithImpl<$Res> extends _$RunDraftCopyWithImpl<$Res>
    implements _$RunCreationCopyWith<$Res> {
  __$RunCreationCopyWithImpl(
      _RunCreation _value, $Res Function(_RunCreation) _then)
      : super(_value, (v) => _then(v as _RunCreation));

  @override
  _RunCreation get _value => super._value as _RunCreation;

  @override
  $Res call({
    Object? timeOfDay = freezed,
    Object? zoneIds = freezed,
    Object? duration = freezed,
  }) {
    return _then(_RunCreation(
      timeOfDay: timeOfDay == freezed
          ? _value.timeOfDay
          : timeOfDay // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      zoneIds: zoneIds == freezed
          ? _value.zoneIds
          : zoneIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc

class _$_RunCreation implements _RunCreation {
  _$_RunCreation(
      {required this.timeOfDay, required this.zoneIds, required this.duration});

  @override
  final TimeOfDay timeOfDay;
  @override
  final List<int> zoneIds;
  @override
  final Duration duration;

  @override
  String toString() {
    return 'RunDraft.creation(timeOfDay: $timeOfDay, zoneIds: $zoneIds, duration: $duration)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RunCreation &&
            const DeepCollectionEquality().equals(other.timeOfDay, timeOfDay) &&
            const DeepCollectionEquality().equals(other.zoneIds, zoneIds) &&
            const DeepCollectionEquality().equals(other.duration, duration));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(timeOfDay),
      const DeepCollectionEquality().hash(zoneIds),
      const DeepCollectionEquality().hash(duration));

  @JsonKey(ignore: true)
  @override
  _$RunCreationCopyWith<_RunCreation> get copyWith =>
      __$RunCreationCopyWithImpl<_RunCreation>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            TimeOfDay timeOfDay, List<int> zoneIds, Duration duration)
        creation,
    required TResult Function(
            TimeOfDay timeOfDay, List<int> zoneIds, Duration duration)
        modification,
  }) {
    return creation(timeOfDay, zoneIds, duration);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(TimeOfDay timeOfDay, List<int> zoneIds, Duration duration)?
        creation,
    TResult Function(TimeOfDay timeOfDay, List<int> zoneIds, Duration duration)?
        modification,
  }) {
    return creation?.call(timeOfDay, zoneIds, duration);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TimeOfDay timeOfDay, List<int> zoneIds, Duration duration)?
        creation,
    TResult Function(TimeOfDay timeOfDay, List<int> zoneIds, Duration duration)?
        modification,
    required TResult orElse(),
  }) {
    if (creation != null) {
      return creation(timeOfDay, zoneIds, duration);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RunCreation value) creation,
    required TResult Function(_RunModification value) modification,
  }) {
    return creation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_RunCreation value)? creation,
    TResult Function(_RunModification value)? modification,
  }) {
    return creation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RunCreation value)? creation,
    TResult Function(_RunModification value)? modification,
    required TResult orElse(),
  }) {
    if (creation != null) {
      return creation(this);
    }
    return orElse();
  }
}

abstract class _RunCreation implements RunDraft {
  factory _RunCreation(
      {required TimeOfDay timeOfDay,
      required List<int> zoneIds,
      required Duration duration}) = _$_RunCreation;

  @override
  TimeOfDay get timeOfDay;
  @override
  List<int> get zoneIds;
  @override
  Duration get duration;
  @override
  @JsonKey(ignore: true)
  _$RunCreationCopyWith<_RunCreation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$RunModificationCopyWith<$Res>
    implements $RunDraftCopyWith<$Res> {
  factory _$RunModificationCopyWith(
          _RunModification value, $Res Function(_RunModification) then) =
      __$RunModificationCopyWithImpl<$Res>;
  @override
  $Res call({TimeOfDay timeOfDay, List<int> zoneIds, Duration duration});
}

/// @nodoc
class __$RunModificationCopyWithImpl<$Res> extends _$RunDraftCopyWithImpl<$Res>
    implements _$RunModificationCopyWith<$Res> {
  __$RunModificationCopyWithImpl(
      _RunModification _value, $Res Function(_RunModification) _then)
      : super(_value, (v) => _then(v as _RunModification));

  @override
  _RunModification get _value => super._value as _RunModification;

  @override
  $Res call({
    Object? timeOfDay = freezed,
    Object? zoneIds = freezed,
    Object? duration = freezed,
  }) {
    return _then(_RunModification(
      timeOfDay: timeOfDay == freezed
          ? _value.timeOfDay
          : timeOfDay // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      zoneIds: zoneIds == freezed
          ? _value.zoneIds
          : zoneIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc

class _$_RunModification implements _RunModification {
  _$_RunModification(
      {required this.timeOfDay, required this.zoneIds, required this.duration});

  @override
  final TimeOfDay timeOfDay;
  @override
  final List<int> zoneIds;
  @override
  final Duration duration;

  @override
  String toString() {
    return 'RunDraft.modification(timeOfDay: $timeOfDay, zoneIds: $zoneIds, duration: $duration)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RunModification &&
            const DeepCollectionEquality().equals(other.timeOfDay, timeOfDay) &&
            const DeepCollectionEquality().equals(other.zoneIds, zoneIds) &&
            const DeepCollectionEquality().equals(other.duration, duration));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(timeOfDay),
      const DeepCollectionEquality().hash(zoneIds),
      const DeepCollectionEquality().hash(duration));

  @JsonKey(ignore: true)
  @override
  _$RunModificationCopyWith<_RunModification> get copyWith =>
      __$RunModificationCopyWithImpl<_RunModification>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            TimeOfDay timeOfDay, List<int> zoneIds, Duration duration)
        creation,
    required TResult Function(
            TimeOfDay timeOfDay, List<int> zoneIds, Duration duration)
        modification,
  }) {
    return modification(timeOfDay, zoneIds, duration);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(TimeOfDay timeOfDay, List<int> zoneIds, Duration duration)?
        creation,
    TResult Function(TimeOfDay timeOfDay, List<int> zoneIds, Duration duration)?
        modification,
  }) {
    return modification?.call(timeOfDay, zoneIds, duration);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TimeOfDay timeOfDay, List<int> zoneIds, Duration duration)?
        creation,
    TResult Function(TimeOfDay timeOfDay, List<int> zoneIds, Duration duration)?
        modification,
    required TResult orElse(),
  }) {
    if (modification != null) {
      return modification(timeOfDay, zoneIds, duration);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RunCreation value) creation,
    required TResult Function(_RunModification value) modification,
  }) {
    return modification(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_RunCreation value)? creation,
    TResult Function(_RunModification value)? modification,
  }) {
    return modification?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RunCreation value)? creation,
    TResult Function(_RunModification value)? modification,
    required TResult orElse(),
  }) {
    if (modification != null) {
      return modification(this);
    }
    return orElse();
  }
}

abstract class _RunModification implements RunDraft {
  factory _RunModification(
      {required TimeOfDay timeOfDay,
      required List<int> zoneIds,
      required Duration duration}) = _$_RunModification;

  @override
  TimeOfDay get timeOfDay;
  @override
  List<int> get zoneIds;
  @override
  Duration get duration;
  @override
  @JsonKey(ignore: true)
  _$RunModificationCopyWith<_RunModification> get copyWith =>
      throw _privateConstructorUsedError;
}
