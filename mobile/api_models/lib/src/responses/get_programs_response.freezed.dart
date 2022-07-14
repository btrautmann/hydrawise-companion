// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'get_programs_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GetProgramsResponse _$GetProgramsResponseFromJson(Map<String, dynamic> json) {
  return _GetProgramsResponse.fromJson(json);
}

/// @nodoc
mixin _$GetProgramsResponse {
  @JsonKey(name: 'programs')
  List<Program> get programs => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetProgramsResponseCopyWith<GetProgramsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetProgramsResponseCopyWith<$Res> {
  factory $GetProgramsResponseCopyWith(
          GetProgramsResponse value, $Res Function(GetProgramsResponse) then) =
      _$GetProgramsResponseCopyWithImpl<$Res>;
  $Res call({@JsonKey(name: 'programs') List<Program> programs});
}

/// @nodoc
class _$GetProgramsResponseCopyWithImpl<$Res>
    implements $GetProgramsResponseCopyWith<$Res> {
  _$GetProgramsResponseCopyWithImpl(this._value, this._then);

  final GetProgramsResponse _value;
  // ignore: unused_field
  final $Res Function(GetProgramsResponse) _then;

  @override
  $Res call({
    Object? programs = freezed,
  }) {
    return _then(_value.copyWith(
      programs: programs == freezed
          ? _value.programs
          : programs // ignore: cast_nullable_to_non_nullable
              as List<Program>,
    ));
  }
}

/// @nodoc
abstract class _$$_GetProgramsResponseCopyWith<$Res>
    implements $GetProgramsResponseCopyWith<$Res> {
  factory _$$_GetProgramsResponseCopyWith(_$_GetProgramsResponse value,
          $Res Function(_$_GetProgramsResponse) then) =
      __$$_GetProgramsResponseCopyWithImpl<$Res>;
  @override
  $Res call({@JsonKey(name: 'programs') List<Program> programs});
}

/// @nodoc
class __$$_GetProgramsResponseCopyWithImpl<$Res>
    extends _$GetProgramsResponseCopyWithImpl<$Res>
    implements _$$_GetProgramsResponseCopyWith<$Res> {
  __$$_GetProgramsResponseCopyWithImpl(_$_GetProgramsResponse _value,
      $Res Function(_$_GetProgramsResponse) _then)
      : super(_value, (v) => _then(v as _$_GetProgramsResponse));

  @override
  _$_GetProgramsResponse get _value => super._value as _$_GetProgramsResponse;

  @override
  $Res call({
    Object? programs = freezed,
  }) {
    return _then(_$_GetProgramsResponse(
      programs: programs == freezed
          ? _value._programs
          : programs // ignore: cast_nullable_to_non_nullable
              as List<Program>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GetProgramsResponse implements _GetProgramsResponse {
  _$_GetProgramsResponse(
      {@JsonKey(name: 'programs') required final List<Program> programs})
      : _programs = programs;

  factory _$_GetProgramsResponse.fromJson(Map<String, dynamic> json) =>
      _$$_GetProgramsResponseFromJson(json);

  final List<Program> _programs;
  @override
  @JsonKey(name: 'programs')
  List<Program> get programs {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_programs);
  }

  @override
  String toString() {
    return 'GetProgramsResponse(programs: $programs)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetProgramsResponse &&
            const DeepCollectionEquality().equals(other._programs, _programs));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_programs));

  @JsonKey(ignore: true)
  @override
  _$$_GetProgramsResponseCopyWith<_$_GetProgramsResponse> get copyWith =>
      __$$_GetProgramsResponseCopyWithImpl<_$_GetProgramsResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GetProgramsResponseToJson(this);
  }
}

abstract class _GetProgramsResponse implements GetProgramsResponse {
  factory _GetProgramsResponse(
          {@JsonKey(name: 'programs') required final List<Program> programs}) =
      _$_GetProgramsResponse;

  factory _GetProgramsResponse.fromJson(Map<String, dynamic> json) =
      _$_GetProgramsResponse.fromJson;

  @override
  @JsonKey(name: 'programs')
  List<Program> get programs;
  @override
  @JsonKey(ignore: true)
  _$$_GetProgramsResponseCopyWith<_$_GetProgramsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

Program _$ProgramFromJson(Map<String, dynamic> json) {
  return _Program.fromJson(json);
}

/// @nodoc
mixin _$Program {
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'frequency')
  List<int> get frequency => throw _privateConstructorUsedError;
  @JsonKey(name: 'runs')
  List<Run> get runs => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProgramCopyWith<Program> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgramCopyWith<$Res> {
  factory $ProgramCopyWith(Program value, $Res Function(Program) then) =
      _$ProgramCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'frequency') List<int> frequency,
      @JsonKey(name: 'runs') List<Run> runs});
}

/// @nodoc
class _$ProgramCopyWithImpl<$Res> implements $ProgramCopyWith<$Res> {
  _$ProgramCopyWithImpl(this._value, this._then);

  final Program _value;
  // ignore: unused_field
  final $Res Function(Program) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? frequency = freezed,
    Object? runs = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      frequency: frequency == freezed
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as List<int>,
      runs: runs == freezed
          ? _value.runs
          : runs // ignore: cast_nullable_to_non_nullable
              as List<Run>,
    ));
  }
}

/// @nodoc
abstract class _$$_ProgramCopyWith<$Res> implements $ProgramCopyWith<$Res> {
  factory _$$_ProgramCopyWith(
          _$_Program value, $Res Function(_$_Program) then) =
      __$$_ProgramCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'frequency') List<int> frequency,
      @JsonKey(name: 'runs') List<Run> runs});
}

/// @nodoc
class __$$_ProgramCopyWithImpl<$Res> extends _$ProgramCopyWithImpl<$Res>
    implements _$$_ProgramCopyWith<$Res> {
  __$$_ProgramCopyWithImpl(_$_Program _value, $Res Function(_$_Program) _then)
      : super(_value, (v) => _then(v as _$_Program));

  @override
  _$_Program get _value => super._value as _$_Program;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? frequency = freezed,
    Object? runs = freezed,
  }) {
    return _then(_$_Program(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      frequency: frequency == freezed
          ? _value._frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as List<int>,
      runs: runs == freezed
          ? _value._runs
          : runs // ignore: cast_nullable_to_non_nullable
              as List<Run>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Program implements _Program {
  _$_Program(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'name') required this.name,
      @JsonKey(name: 'frequency') required final List<int> frequency,
      @JsonKey(name: 'runs') required final List<Run> runs})
      : _frequency = frequency,
        _runs = runs;

  factory _$_Program.fromJson(Map<String, dynamic> json) =>
      _$$_ProgramFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'name')
  final String name;
  final List<int> _frequency;
  @override
  @JsonKey(name: 'frequency')
  List<int> get frequency {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_frequency);
  }

  final List<Run> _runs;
  @override
  @JsonKey(name: 'runs')
  List<Run> get runs {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_runs);
  }

  @override
  String toString() {
    return 'Program(id: $id, name: $name, frequency: $frequency, runs: $runs)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Program &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other._frequency, _frequency) &&
            const DeepCollectionEquality().equals(other._runs, _runs));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(_frequency),
      const DeepCollectionEquality().hash(_runs));

  @JsonKey(ignore: true)
  @override
  _$$_ProgramCopyWith<_$_Program> get copyWith =>
      __$$_ProgramCopyWithImpl<_$_Program>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProgramToJson(this);
  }
}

abstract class _Program implements Program {
  factory _Program(
      {@JsonKey(name: 'id') required final String id,
      @JsonKey(name: 'name') required final String name,
      @JsonKey(name: 'frequency') required final List<int> frequency,
      @JsonKey(name: 'runs') required final List<Run> runs}) = _$_Program;

  factory _Program.fromJson(Map<String, dynamic> json) = _$_Program.fromJson;

  @override
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'name')
  String get name;
  @override
  @JsonKey(name: 'frequency')
  List<int> get frequency;
  @override
  @JsonKey(name: 'runs')
  List<Run> get runs;
  @override
  @JsonKey(ignore: true)
  _$$_ProgramCopyWith<_$_Program> get copyWith =>
      throw _privateConstructorUsedError;
}

Run _$RunFromJson(Map<String, dynamic> json) {
  return _Run.fromJson(json);
}

/// @nodoc
mixin _$Run {
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'program_id')
  String get programId => throw _privateConstructorUsedError;
  @JsonKey(name: 'zone_id')
  int get zoneId => throw _privateConstructorUsedError;
  @JsonKey(name: 'duration_sec')
  int get durationSeconds => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_hour')
  int get startHour => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_minute')
  int get startMinute => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RunCopyWith<Run> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RunCopyWith<$Res> {
  factory $RunCopyWith(Run value, $Res Function(Run) then) =
      _$RunCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'program_id') String programId,
      @JsonKey(name: 'zone_id') int zoneId,
      @JsonKey(name: 'duration_sec') int durationSeconds,
      @JsonKey(name: 'start_hour') int startHour,
      @JsonKey(name: 'start_minute') int startMinute});
}

/// @nodoc
class _$RunCopyWithImpl<$Res> implements $RunCopyWith<$Res> {
  _$RunCopyWithImpl(this._value, this._then);

  final Run _value;
  // ignore: unused_field
  final $Res Function(Run) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? programId = freezed,
    Object? zoneId = freezed,
    Object? durationSeconds = freezed,
    Object? startHour = freezed,
    Object? startMinute = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      programId: programId == freezed
          ? _value.programId
          : programId // ignore: cast_nullable_to_non_nullable
              as String,
      zoneId: zoneId == freezed
          ? _value.zoneId
          : zoneId // ignore: cast_nullable_to_non_nullable
              as int,
      durationSeconds: durationSeconds == freezed
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      startHour: startHour == freezed
          ? _value.startHour
          : startHour // ignore: cast_nullable_to_non_nullable
              as int,
      startMinute: startMinute == freezed
          ? _value.startMinute
          : startMinute // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_RunCopyWith<$Res> implements $RunCopyWith<$Res> {
  factory _$$_RunCopyWith(_$_Run value, $Res Function(_$_Run) then) =
      __$$_RunCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'program_id') String programId,
      @JsonKey(name: 'zone_id') int zoneId,
      @JsonKey(name: 'duration_sec') int durationSeconds,
      @JsonKey(name: 'start_hour') int startHour,
      @JsonKey(name: 'start_minute') int startMinute});
}

/// @nodoc
class __$$_RunCopyWithImpl<$Res> extends _$RunCopyWithImpl<$Res>
    implements _$$_RunCopyWith<$Res> {
  __$$_RunCopyWithImpl(_$_Run _value, $Res Function(_$_Run) _then)
      : super(_value, (v) => _then(v as _$_Run));

  @override
  _$_Run get _value => super._value as _$_Run;

  @override
  $Res call({
    Object? id = freezed,
    Object? programId = freezed,
    Object? zoneId = freezed,
    Object? durationSeconds = freezed,
    Object? startHour = freezed,
    Object? startMinute = freezed,
  }) {
    return _then(_$_Run(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      programId: programId == freezed
          ? _value.programId
          : programId // ignore: cast_nullable_to_non_nullable
              as String,
      zoneId: zoneId == freezed
          ? _value.zoneId
          : zoneId // ignore: cast_nullable_to_non_nullable
              as int,
      durationSeconds: durationSeconds == freezed
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      startHour: startHour == freezed
          ? _value.startHour
          : startHour // ignore: cast_nullable_to_non_nullable
              as int,
      startMinute: startMinute == freezed
          ? _value.startMinute
          : startMinute // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Run implements _Run {
  _$_Run(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'program_id') required this.programId,
      @JsonKey(name: 'zone_id') required this.zoneId,
      @JsonKey(name: 'duration_sec') required this.durationSeconds,
      @JsonKey(name: 'start_hour') required this.startHour,
      @JsonKey(name: 'start_minute') required this.startMinute});

  factory _$_Run.fromJson(Map<String, dynamic> json) => _$$_RunFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'program_id')
  final String programId;
  @override
  @JsonKey(name: 'zone_id')
  final int zoneId;
  @override
  @JsonKey(name: 'duration_sec')
  final int durationSeconds;
  @override
  @JsonKey(name: 'start_hour')
  final int startHour;
  @override
  @JsonKey(name: 'start_minute')
  final int startMinute;

  @override
  String toString() {
    return 'Run(id: $id, programId: $programId, zoneId: $zoneId, durationSeconds: $durationSeconds, startHour: $startHour, startMinute: $startMinute)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Run &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.programId, programId) &&
            const DeepCollectionEquality().equals(other.zoneId, zoneId) &&
            const DeepCollectionEquality()
                .equals(other.durationSeconds, durationSeconds) &&
            const DeepCollectionEquality().equals(other.startHour, startHour) &&
            const DeepCollectionEquality()
                .equals(other.startMinute, startMinute));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(programId),
      const DeepCollectionEquality().hash(zoneId),
      const DeepCollectionEquality().hash(durationSeconds),
      const DeepCollectionEquality().hash(startHour),
      const DeepCollectionEquality().hash(startMinute));

  @JsonKey(ignore: true)
  @override
  _$$_RunCopyWith<_$_Run> get copyWith =>
      __$$_RunCopyWithImpl<_$_Run>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RunToJson(this);
  }
}

abstract class _Run implements Run {
  factory _Run(
      {@JsonKey(name: 'id') required final String id,
      @JsonKey(name: 'program_id') required final String programId,
      @JsonKey(name: 'zone_id') required final int zoneId,
      @JsonKey(name: 'duration_sec') required final int durationSeconds,
      @JsonKey(name: 'start_hour') required final int startHour,
      @JsonKey(name: 'start_minute') required final int startMinute}) = _$_Run;

  factory _Run.fromJson(Map<String, dynamic> json) = _$_Run.fromJson;

  @override
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'program_id')
  String get programId;
  @override
  @JsonKey(name: 'zone_id')
  int get zoneId;
  @override
  @JsonKey(name: 'duration_sec')
  int get durationSeconds;
  @override
  @JsonKey(name: 'start_hour')
  int get startHour;
  @override
  @JsonKey(name: 'start_minute')
  int get startMinute;
  @override
  @JsonKey(ignore: true)
  _$$_RunCopyWith<_$_Run> get copyWith => throw _privateConstructorUsedError;
}
