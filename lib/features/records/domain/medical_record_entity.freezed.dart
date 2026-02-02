// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'medical_record_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MedicalRecordEntity _$MedicalRecordEntityFromJson(Map<String, dynamic> json) {
  return _MedicalRecordEntity.fromJson(json);
}

/// @nodoc
mixin _$MedicalRecordEntity {
  String get id => throw _privateConstructorUsedError;
  String get patientId => throw _privateConstructorUsedError;
  String get dentistId => throw _privateConstructorUsedError;
  String get diagnosis => throw _privateConstructorUsedError;
  String get treatmentNotes => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  List<String>? get attachmentUrls => throw _privateConstructorUsedError;

  /// Serializes this MedicalRecordEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MedicalRecordEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MedicalRecordEntityCopyWith<MedicalRecordEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MedicalRecordEntityCopyWith<$Res> {
  factory $MedicalRecordEntityCopyWith(
    MedicalRecordEntity value,
    $Res Function(MedicalRecordEntity) then,
  ) = _$MedicalRecordEntityCopyWithImpl<$Res, MedicalRecordEntity>;
  @useResult
  $Res call({
    String id,
    String patientId,
    String dentistId,
    String diagnosis,
    String treatmentNotes,
    DateTime date,
    List<String>? attachmentUrls,
  });
}

/// @nodoc
class _$MedicalRecordEntityCopyWithImpl<$Res, $Val extends MedicalRecordEntity>
    implements $MedicalRecordEntityCopyWith<$Res> {
  _$MedicalRecordEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MedicalRecordEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? patientId = null,
    Object? dentistId = null,
    Object? diagnosis = null,
    Object? treatmentNotes = null,
    Object? date = null,
    Object? attachmentUrls = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            patientId: null == patientId
                ? _value.patientId
                : patientId // ignore: cast_nullable_to_non_nullable
                      as String,
            dentistId: null == dentistId
                ? _value.dentistId
                : dentistId // ignore: cast_nullable_to_non_nullable
                      as String,
            diagnosis: null == diagnosis
                ? _value.diagnosis
                : diagnosis // ignore: cast_nullable_to_non_nullable
                      as String,
            treatmentNotes: null == treatmentNotes
                ? _value.treatmentNotes
                : treatmentNotes // ignore: cast_nullable_to_non_nullable
                      as String,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            attachmentUrls: freezed == attachmentUrls
                ? _value.attachmentUrls
                : attachmentUrls // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MedicalRecordEntityImplCopyWith<$Res>
    implements $MedicalRecordEntityCopyWith<$Res> {
  factory _$$MedicalRecordEntityImplCopyWith(
    _$MedicalRecordEntityImpl value,
    $Res Function(_$MedicalRecordEntityImpl) then,
  ) = __$$MedicalRecordEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String patientId,
    String dentistId,
    String diagnosis,
    String treatmentNotes,
    DateTime date,
    List<String>? attachmentUrls,
  });
}

/// @nodoc
class __$$MedicalRecordEntityImplCopyWithImpl<$Res>
    extends _$MedicalRecordEntityCopyWithImpl<$Res, _$MedicalRecordEntityImpl>
    implements _$$MedicalRecordEntityImplCopyWith<$Res> {
  __$$MedicalRecordEntityImplCopyWithImpl(
    _$MedicalRecordEntityImpl _value,
    $Res Function(_$MedicalRecordEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MedicalRecordEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? patientId = null,
    Object? dentistId = null,
    Object? diagnosis = null,
    Object? treatmentNotes = null,
    Object? date = null,
    Object? attachmentUrls = freezed,
  }) {
    return _then(
      _$MedicalRecordEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        patientId: null == patientId
            ? _value.patientId
            : patientId // ignore: cast_nullable_to_non_nullable
                  as String,
        dentistId: null == dentistId
            ? _value.dentistId
            : dentistId // ignore: cast_nullable_to_non_nullable
                  as String,
        diagnosis: null == diagnosis
            ? _value.diagnosis
            : diagnosis // ignore: cast_nullable_to_non_nullable
                  as String,
        treatmentNotes: null == treatmentNotes
            ? _value.treatmentNotes
            : treatmentNotes // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        attachmentUrls: freezed == attachmentUrls
            ? _value._attachmentUrls
            : attachmentUrls // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MedicalRecordEntityImpl implements _MedicalRecordEntity {
  const _$MedicalRecordEntityImpl({
    required this.id,
    required this.patientId,
    required this.dentistId,
    required this.diagnosis,
    required this.treatmentNotes,
    required this.date,
    final List<String>? attachmentUrls,
  }) : _attachmentUrls = attachmentUrls;

  factory _$MedicalRecordEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$MedicalRecordEntityImplFromJson(json);

  @override
  final String id;
  @override
  final String patientId;
  @override
  final String dentistId;
  @override
  final String diagnosis;
  @override
  final String treatmentNotes;
  @override
  final DateTime date;
  final List<String>? _attachmentUrls;
  @override
  List<String>? get attachmentUrls {
    final value = _attachmentUrls;
    if (value == null) return null;
    if (_attachmentUrls is EqualUnmodifiableListView) return _attachmentUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'MedicalRecordEntity(id: $id, patientId: $patientId, dentistId: $dentistId, diagnosis: $diagnosis, treatmentNotes: $treatmentNotes, date: $date, attachmentUrls: $attachmentUrls)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MedicalRecordEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.patientId, patientId) ||
                other.patientId == patientId) &&
            (identical(other.dentistId, dentistId) ||
                other.dentistId == dentistId) &&
            (identical(other.diagnosis, diagnosis) ||
                other.diagnosis == diagnosis) &&
            (identical(other.treatmentNotes, treatmentNotes) ||
                other.treatmentNotes == treatmentNotes) &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality().equals(
              other._attachmentUrls,
              _attachmentUrls,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    patientId,
    dentistId,
    diagnosis,
    treatmentNotes,
    date,
    const DeepCollectionEquality().hash(_attachmentUrls),
  );

  /// Create a copy of MedicalRecordEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MedicalRecordEntityImplCopyWith<_$MedicalRecordEntityImpl> get copyWith =>
      __$$MedicalRecordEntityImplCopyWithImpl<_$MedicalRecordEntityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MedicalRecordEntityImplToJson(this);
  }
}

abstract class _MedicalRecordEntity implements MedicalRecordEntity {
  const factory _MedicalRecordEntity({
    required final String id,
    required final String patientId,
    required final String dentistId,
    required final String diagnosis,
    required final String treatmentNotes,
    required final DateTime date,
    final List<String>? attachmentUrls,
  }) = _$MedicalRecordEntityImpl;

  factory _MedicalRecordEntity.fromJson(Map<String, dynamic> json) =
      _$MedicalRecordEntityImpl.fromJson;

  @override
  String get id;
  @override
  String get patientId;
  @override
  String get dentistId;
  @override
  String get diagnosis;
  @override
  String get treatmentNotes;
  @override
  DateTime get date;
  @override
  List<String>? get attachmentUrls;

  /// Create a copy of MedicalRecordEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MedicalRecordEntityImplCopyWith<_$MedicalRecordEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
