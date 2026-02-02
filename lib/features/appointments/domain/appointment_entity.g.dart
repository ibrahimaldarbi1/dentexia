// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppointmentEntityImpl _$$AppointmentEntityImplFromJson(
  Map<String, dynamic> json,
) => _$AppointmentEntityImpl(
  id: json['id'] as String,
  dentistId: json['dentistId'] as String,
  patientId: json['patientId'] as String,
  serviceName: json['serviceName'] as String,
  startTime: DateTime.parse(json['startTime'] as String),
  endTime: DateTime.parse(json['endTime'] as String),
  status: json['status'] as String,
  notes: json['notes'] as String?,
  patient: json['patient'] == null
      ? null
      : UserEntity.fromJson(json['patient'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$AppointmentEntityImplToJson(
  _$AppointmentEntityImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'dentistId': instance.dentistId,
  'patientId': instance.patientId,
  'serviceName': instance.serviceName,
  'startTime': instance.startTime.toIso8601String(),
  'endTime': instance.endTime.toIso8601String(),
  'status': instance.status,
  'notes': instance.notes,
  'patient': instance.patient,
};
