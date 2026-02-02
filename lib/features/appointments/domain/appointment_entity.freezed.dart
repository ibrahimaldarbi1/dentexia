// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AppointmentEntity _$AppointmentEntityFromJson(Map<String, dynamic> json) {
  return _AppointmentEntity.fromJson(json);
}

/// @nodoc
mixin _$AppointmentEntity {
  String get id => throw _privateConstructorUsedError;
  String get dentistId => throw _privateConstructorUsedError;
  String get patientId => throw _privateConstructorUsedError;
  String get serviceName =>
      throw _privateConstructorUsedError; // Flattened from join for simpler UI
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  UserEntity? get patient => throw _privateConstructorUsedError;

  /// Serializes this AppointmentEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppointmentEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppointmentEntityCopyWith<AppointmentEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppointmentEntityCopyWith<$Res> {
  factory $AppointmentEntityCopyWith(
    AppointmentEntity value,
    $Res Function(AppointmentEntity) then,
  ) = _$AppointmentEntityCopyWithImpl<$Res, AppointmentEntity>;
  @useResult
  $Res call({
    String id,
    String dentistId,
    String patientId,
    String serviceName,
    DateTime startTime,
    DateTime endTime,
    String status,
    String? notes,
    UserEntity? patient,
  });

  $UserEntityCopyWith<$Res>? get patient;
}

/// @nodoc
class _$AppointmentEntityCopyWithImpl<$Res, $Val extends AppointmentEntity>
    implements $AppointmentEntityCopyWith<$Res> {
  _$AppointmentEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppointmentEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? dentistId = null,
    Object? patientId = null,
    Object? serviceName = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? status = null,
    Object? notes = freezed,
    Object? patient = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            dentistId: null == dentistId
                ? _value.dentistId
                : dentistId // ignore: cast_nullable_to_non_nullable
                      as String,
            patientId: null == patientId
                ? _value.patientId
                : patientId // ignore: cast_nullable_to_non_nullable
                      as String,
            serviceName: null == serviceName
                ? _value.serviceName
                : serviceName // ignore: cast_nullable_to_non_nullable
                      as String,
            startTime: null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endTime: null == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            patient: freezed == patient
                ? _value.patient
                : patient // ignore: cast_nullable_to_non_nullable
                      as UserEntity?,
          )
          as $Val,
    );
  }

  /// Create a copy of AppointmentEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserEntityCopyWith<$Res>? get patient {
    if (_value.patient == null) {
      return null;
    }

    return $UserEntityCopyWith<$Res>(_value.patient!, (value) {
      return _then(_value.copyWith(patient: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppointmentEntityImplCopyWith<$Res>
    implements $AppointmentEntityCopyWith<$Res> {
  factory _$$AppointmentEntityImplCopyWith(
    _$AppointmentEntityImpl value,
    $Res Function(_$AppointmentEntityImpl) then,
  ) = __$$AppointmentEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String dentistId,
    String patientId,
    String serviceName,
    DateTime startTime,
    DateTime endTime,
    String status,
    String? notes,
    UserEntity? patient,
  });

  @override
  $UserEntityCopyWith<$Res>? get patient;
}

/// @nodoc
class __$$AppointmentEntityImplCopyWithImpl<$Res>
    extends _$AppointmentEntityCopyWithImpl<$Res, _$AppointmentEntityImpl>
    implements _$$AppointmentEntityImplCopyWith<$Res> {
  __$$AppointmentEntityImplCopyWithImpl(
    _$AppointmentEntityImpl _value,
    $Res Function(_$AppointmentEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppointmentEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? dentistId = null,
    Object? patientId = null,
    Object? serviceName = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? status = null,
    Object? notes = freezed,
    Object? patient = freezed,
  }) {
    return _then(
      _$AppointmentEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        dentistId: null == dentistId
            ? _value.dentistId
            : dentistId // ignore: cast_nullable_to_non_nullable
                  as String,
        patientId: null == patientId
            ? _value.patientId
            : patientId // ignore: cast_nullable_to_non_nullable
                  as String,
        serviceName: null == serviceName
            ? _value.serviceName
            : serviceName // ignore: cast_nullable_to_non_nullable
                  as String,
        startTime: null == startTime
            ? _value.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endTime: null == endTime
            ? _value.endTime
            : endTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        patient: freezed == patient
            ? _value.patient
            : patient // ignore: cast_nullable_to_non_nullable
                  as UserEntity?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AppointmentEntityImpl implements _AppointmentEntity {
  const _$AppointmentEntityImpl({
    required this.id,
    required this.dentistId,
    required this.patientId,
    required this.serviceName,
    required this.startTime,
    required this.endTime,
    required this.status,
    this.notes,
    this.patient,
  });

  factory _$AppointmentEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppointmentEntityImplFromJson(json);

  @override
  final String id;
  @override
  final String dentistId;
  @override
  final String patientId;
  @override
  final String serviceName;
  // Flattened from join for simpler UI
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  final String status;
  @override
  final String? notes;
  @override
  final UserEntity? patient;

  @override
  String toString() {
    return 'AppointmentEntity(id: $id, dentistId: $dentistId, patientId: $patientId, serviceName: $serviceName, startTime: $startTime, endTime: $endTime, status: $status, notes: $notes, patient: $patient)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppointmentEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.dentistId, dentistId) ||
                other.dentistId == dentistId) &&
            (identical(other.patientId, patientId) ||
                other.patientId == patientId) &&
            (identical(other.serviceName, serviceName) ||
                other.serviceName == serviceName) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.patient, patient) || other.patient == patient));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    dentistId,
    patientId,
    serviceName,
    startTime,
    endTime,
    status,
    notes,
    patient,
  );

  /// Create a copy of AppointmentEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppointmentEntityImplCopyWith<_$AppointmentEntityImpl> get copyWith =>
      __$$AppointmentEntityImplCopyWithImpl<_$AppointmentEntityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AppointmentEntityImplToJson(this);
  }
}

abstract class _AppointmentEntity implements AppointmentEntity {
  const factory _AppointmentEntity({
    required final String id,
    required final String dentistId,
    required final String patientId,
    required final String serviceName,
    required final DateTime startTime,
    required final DateTime endTime,
    required final String status,
    final String? notes,
    final UserEntity? patient,
  }) = _$AppointmentEntityImpl;

  factory _AppointmentEntity.fromJson(Map<String, dynamic> json) =
      _$AppointmentEntityImpl.fromJson;

  @override
  String get id;
  @override
  String get dentistId;
  @override
  String get patientId;
  @override
  String get serviceName; // Flattened from join for simpler UI
  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  String get status;
  @override
  String? get notes;
  @override
  UserEntity? get patient;

  /// Create a copy of AppointmentEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppointmentEntityImplCopyWith<_$AppointmentEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
