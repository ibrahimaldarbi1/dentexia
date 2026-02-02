import 'package:freezed_annotation/freezed_annotation.dart';
import '../../auth/domain/user_entity.dart'; // Reuse for patient info

part 'appointment_entity.freezed.dart';
part 'appointment_entity.g.dart';

@freezed
class AppointmentEntity with _$AppointmentEntity {
  const factory AppointmentEntity({
    required String id,
    required String dentistId,
    required String patientId,
    required String serviceName, // Flattened from join for simpler UI
    required DateTime startTime,
    required DateTime endTime,
    required String status,
    String? notes,
    UserEntity? patient, // Nested object for UI display
  }) = _AppointmentEntity;

  factory AppointmentEntity.fromJson(Map<String, dynamic> json) => _$AppointmentEntityFromJson(json);
}