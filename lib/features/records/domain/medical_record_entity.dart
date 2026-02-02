import 'package:freezed_annotation/freezed_annotation.dart';

part 'medical_record_entity.freezed.dart';
part 'medical_record_entity.g.dart';

@freezed
class MedicalRecordEntity with _$MedicalRecordEntity {
  const factory MedicalRecordEntity({
    required String id,
    required String patientId,
    required String dentistId,
    required String diagnosis,
    required String treatmentNotes,
    required DateTime date,
    List<String>? attachmentUrls, // X-Rays
  }) = _MedicalRecordEntity;

  factory MedicalRecordEntity.fromJson(Map<String, dynamic> json) => _$MedicalRecordEntityFromJson(json);
}