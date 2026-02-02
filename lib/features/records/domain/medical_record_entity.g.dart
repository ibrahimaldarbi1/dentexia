// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_record_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MedicalRecordEntityImpl _$$MedicalRecordEntityImplFromJson(
  Map<String, dynamic> json,
) => _$MedicalRecordEntityImpl(
  id: json['id'] as String,
  patientId: json['patientId'] as String,
  dentistId: json['dentistId'] as String,
  diagnosis: json['diagnosis'] as String,
  treatmentNotes: json['treatmentNotes'] as String,
  date: DateTime.parse(json['date'] as String),
  attachmentUrls: (json['attachmentUrls'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$$MedicalRecordEntityImplToJson(
  _$MedicalRecordEntityImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'patientId': instance.patientId,
  'dentistId': instance.dentistId,
  'diagnosis': instance.diagnosis,
  'treatmentNotes': instance.treatmentNotes,
  'date': instance.date.toIso8601String(),
  'attachmentUrls': instance.attachmentUrls,
};
