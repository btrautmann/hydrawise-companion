// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'update_program_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UpdateProgramRequest _$UpdateProgramRequestFromJson(Map<String, dynamic> json) {
  return _UpdateProgramRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateProgramRequest {
  @JsonKey(name: 'api_key')
  String get apiKey => throw _privateConstructorUsedError;
  @JsonKey(name: 'program_id')
  String get programId => throw _privateConstructorUsedError;
  @JsonKey(name: 'program_name')
  String get programName => throw _privateConstructorUsedError;
  @JsonKey(name: 'frequency')
  List<int> get frequency => throw _privateConstructorUsedError;
  @JsonKey(name: 'runs_to_create')
  List<RunCreation> get runsToCreate => throw _privateConstructorUsedError;
  @JsonKey(name: 'runs_to_update')
  List<Run> get runsToUpdate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpdateProgramRequestCopyWith<UpdateProgramRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateProgramRequestCopyWith<$Res> {
  factory $UpdateProgramRequestCopyWith(UpdateProgramRequest value,
          $Res Function(UpdateProgramRequest) then) =
      _$UpdateProgramRequestCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'api_key') String apiKey,
      @JsonKey(name: 'program_id') String programId,
      @JsonKey(name: 'program_name') String programName,
      @JsonKey(name: 'frequency') List<int> frequency,
      @JsonKey(name: 'runs_to_create') List<RunCreation> runsToCreate,
      @JsonKey(name: 'runs_to_update') List<Run> runsToUpdate});
}

/// @nodoc
class _$UpdateProgramRequestCopyWithImpl<$Res>
    implements $UpdateProgramRequestCopyWith<$Res> {
  _$UpdateProgramRequestCopyWithImpl(this._value, this._then);

  final UpdateProgramRequest _value;
  // ignore: unused_field
  final $Res Function(UpdateProgramRequest) _then;

  @override
  $Res call({
    Object? apiKey = freezed,
    Object? programId = freezed,
    Object? programName = freezed,
    Object? frequency = freezed,
    Object? runsToCreate = freezed,
    Object? runsToUpdate = freezed,
  }) {
    return _then(_value.copyWith(
      apiKey: apiKey == freezed
          ? _value.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String,
      programId: programId == freezed
          ? _value.programId
          : programId // ignore: cast_nullable_to_non_nullable
              as String,
      programName: programName == freezed
          ? _value.programName
          : programName // ignore: cast_nullable_to_non_nullable
              as String,
      frequency: frequency == freezed
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as List<int>,
      runsToCreate: runsToCreate == freezed
          ? _value.runsToCreate
          : runsToCreate // ignore: cast_nullable_to_non_nullable
              as List<RunCreation>,
      runsToUpdate: runsToUpdate == freezed
          ? _value.runsToUpdate
          : runsToUpdate // ignore: cast_nullable_to_non_nullable
              as List<Run>,
    ));
  }
}

/// @nodoc
abstract class _$$_UpdateProgramRequestCopyWith<$Res>
    implements $UpdateProgramRequestCopyWith<$Res> {
  factory _$$_UpdateProgramRequestCopyWith(_$_UpdateProgramRequest value,
          $Res Function(_$_UpdateProgramRequest) then) =
      __$$_UpdateProgramRequestCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'api_key') String apiKey,
      @JsonKey(name: 'program_id') String programId,
      @JsonKey(name: 'program_name') String programName,
      @JsonKey(name: 'frequency') List<int> frequency,
      @JsonKey(name: 'runs_to_create') List<RunCreation> runsToCreate,
      @JsonKey(name: 'runs_to_update') List<Run> runsToUpdate});
}

/// @nodoc
class __$$_UpdateProgramRequestCopyWithImpl<$Res>
    extends _$UpdateProgramRequestCopyWithImpl<$Res>
    implements _$$_UpdateProgramRequestCopyWith<$Res> {
  __$$_UpdateProgramRequestCopyWithImpl(_$_UpdateProgramRequest _value,
      $Res Function(_$_UpdateProgramRequest) _then)
      : super(_value, (v) => _then(v as _$_UpdateProgramRequest));

  @override
  _$_UpdateProgramRequest get _value => super._value as _$_UpdateProgramRequest;

  @override
  $Res call({
    Object? apiKey = freezed,
    Object? programId = freezed,
    Object? programName = freezed,
    Object? frequency = freezed,
    Object? runsToCreate = freezed,
    Object? runsToUpdate = freezed,
  }) {
    return _then(_$_UpdateProgramRequest(
      apiKey: apiKey == freezed
          ? _value.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String,
      programId: programId == freezed
          ? _value.programId
          : programId // ignore: cast_nullable_to_non_nullable
              as String,
      programName: programName == freezed
          ? _value.programName
          : programName // ignore: cast_nullable_to_non_nullable
              as String,
      frequency: frequency == freezed
          ? _value._frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as List<int>,
      runsToCreate: runsToCreate == freezed
          ? _value._runsToCreate
          : runsToCreate // ignore: cast_nullable_to_non_nullable
              as List<RunCreation>,
      runsToUpdate: runsToUpdate == freezed
          ? _value._runsToUpdate
          : runsToUpdate // ignore: cast_nullable_to_non_nullable
              as List<Run>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UpdateProgramRequest implements _UpdateProgramRequest {
  _$_UpdateProgramRequest(
      {@JsonKey(name: 'api_key')
          required this.apiKey,
      @JsonKey(name: 'program_id')
          required this.programId,
      @JsonKey(name: 'program_name')
          required this.programName,
      @JsonKey(name: 'frequency')
          required final List<int> frequency,
      @JsonKey(name: 'runs_to_create')
          required final List<RunCreation> runsToCreate,
      @JsonKey(name: 'runs_to_update')
          required final List<Run> runsToUpdate})
      : _frequency = frequency,
        _runsToCreate = runsToCreate,
        _runsToUpdate = runsToUpdate;

  factory _$_UpdateProgramRequest.fromJson(Map<String, dynamic> json) =>
      _$$_UpdateProgramRequestFromJson(json);

  @override
  @JsonKey(name: 'api_key')
  final String apiKey;
  @override
  @JsonKey(name: 'program_id')
  final String programId;
  @override
  @JsonKey(name: 'program_name')
  final String programName;
  final List<int> _frequency;
  @override
  @JsonKey(name: 'frequency')
  List<int> get frequency {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_frequency);
  }

  final List<RunCreation> _runsToCreate;
  @override
  @JsonKey(name: 'runs_to_create')
  List<RunCreation> get runsToCreate {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_runsToCreate);
  }

  final List<Run> _runsToUpdate;
  @override
  @JsonKey(name: 'runs_to_update')
  List<Run> get runsToUpdate {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_runsToUpdate);
  }

  @override
  String toString() {
    return 'UpdateProgramRequest(apiKey: $apiKey, programId: $programId, programName: $programName, frequency: $frequency, runsToCreate: $runsToCreate, runsToUpdate: $runsToUpdate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UpdateProgramRequest &&
            const DeepCollectionEquality().equals(other.apiKey, apiKey) &&
            const DeepCollectionEquality().equals(other.programId, programId) &&
            const DeepCollectionEquality()
                .equals(other.programName, programName) &&
            const DeepCollectionEquality()
                .equals(other._frequency, _frequency) &&
            const DeepCollectionEquality()
                .equals(other._runsToCreate, _runsToCreate) &&
            const DeepCollectionEquality()
                .equals(other._runsToUpdate, _runsToUpdate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(apiKey),
      const DeepCollectionEquality().hash(programId),
      const DeepCollectionEquality().hash(programName),
      const DeepCollectionEquality().hash(_frequency),
      const DeepCollectionEquality().hash(_runsToCreate),
      const DeepCollectionEquality().hash(_runsToUpdate));

  @JsonKey(ignore: true)
  @override
  _$$_UpdateProgramRequestCopyWith<_$_UpdateProgramRequest> get copyWith =>
      __$$_UpdateProgramRequestCopyWithImpl<_$_UpdateProgramRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UpdateProgramRequestToJson(this);
  }
}

abstract class _UpdateProgramRequest implements UpdateProgramRequest {
  factory _UpdateProgramRequest(
      {@JsonKey(name: 'api_key')
          required final String apiKey,
      @JsonKey(name: 'program_id')
          required final String programId,
      @JsonKey(name: 'program_name')
          required final String programName,
      @JsonKey(name: 'frequency')
          required final List<int> frequency,
      @JsonKey(name: 'runs_to_create')
          required final List<RunCreation> runsToCreate,
      @JsonKey(name: 'runs_to_update')
          required final List<Run> runsToUpdate}) = _$_UpdateProgramRequest;

  factory _UpdateProgramRequest.fromJson(Map<String, dynamic> json) =
      _$_UpdateProgramRequest.fromJson;

  @override
  @JsonKey(name: 'api_key')
  String get apiKey;
  @override
  @JsonKey(name: 'program_id')
  String get programId;
  @override
  @JsonKey(name: 'program_name')
  String get programName;
  @override
  @JsonKey(name: 'frequency')
  List<int> get frequency;
  @override
  @JsonKey(name: 'runs_to_create')
  List<RunCreation> get runsToCreate;
  @override
  @JsonKey(name: 'runs_to_update')
  List<Run> get runsToUpdate;
  @override
  @JsonKey(ignore: true)
  _$$_UpdateProgramRequestCopyWith<_$_UpdateProgramRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
