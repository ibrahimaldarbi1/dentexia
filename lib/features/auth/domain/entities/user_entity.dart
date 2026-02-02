import 'package:equatable/equatable.dart';

enum UserRole { admin, dentist, patient, unknown }

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String fullName;
  final UserRole role;
  final String? avatarUrl;
  final String? phoneNumber;
  final DateTime? dateOfBirth;
  final DateTime createdAt;
  
  // Role-specific fields
  final String? dentistLicenseNumber;
  final String? dentistSpecialization;
  final int? dentistYearsExperience;
  final String? dentistClinicAddress;
  final double? dentistConsultationFee;
  
  final String? patientInsuranceProvider;
  final String? patientInsuranceId;
  final String? patientEmergencyContact;
  final String? patientMedicalHistory;

  const UserEntity({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
    this.avatarUrl,
    this.phoneNumber,
    this.dateOfBirth,
    required this.createdAt,
    this.dentistLicenseNumber,
    this.dentistSpecialization,
    this.dentistYearsExperience,
    this.dentistClinicAddress,
    this.dentistConsultationFee,
    this.patientInsuranceProvider,
    this.patientInsuranceId,
    this.patientEmergencyContact,
    this.patientMedicalHistory,
  });

  bool get isAdmin => role == UserRole.admin;
  bool get isDentist => role == UserRole.dentist;
  bool get isPatient => role == UserRole.patient;

  @override
  List<Object?> get props => [id, email, role];
}