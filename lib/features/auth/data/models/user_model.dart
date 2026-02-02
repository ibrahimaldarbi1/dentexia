import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String fullName;
  final String role;
  final String? avatarUrl;
  final String? phoneNumber;
  final DateTime? dateOfBirth;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  final String? dentistLicenseNumber;
  final String? dentistSpecialization;
  final int? dentistYearsExperience;
  final String? dentistClinicAddress;
  final double? dentistConsultationFee;
  
  final String? patientInsuranceProvider;
  final String? patientInsuranceId;
  final String? patientEmergencyContact;
  final String? patientMedicalHistory;

  const UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
    this.avatarUrl,
    this.phoneNumber,
    this.dateOfBirth,
    required this.createdAt,
    required this.updatedAt,
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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['full_name'] as String,
      role: json['role'] as String,
      avatarUrl: json['avatar_url'] as String?,
      phoneNumber: json['phone_number'] as String?,
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.parse(json['date_of_birth'] as String)
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      dentistLicenseNumber: json['dentist_license_number'] as String?,
      dentistSpecialization: json['dentist_specialization'] as String?,
      dentistYearsExperience: json['dentist_years_experience'] as int?,
      dentistClinicAddress: json['dentist_clinic_address'] as String?,
      dentistConsultationFee: (json['dentist_consultation_fee'] as num?)?.toDouble(),
      patientInsuranceProvider: json['patient_insurance_provider'] as String?,
      patientInsuranceId: json['patient_insurance_id'] as String?,
      patientEmergencyContact: json['patient_emergency_contact'] as String?,
      patientMedicalHistory: json['patient_medical_history'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'role': role,
      'avatar_url': avatarUrl,
      'phone_number': phoneNumber,
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'dentist_license_number': dentistLicenseNumber,
      'dentist_specialization': dentistSpecialization,
      'dentist_years_experience': dentistYearsExperience,
      'dentist_clinic_address': dentistClinicAddress,
      'dentist_consultation_fee': dentistConsultationFee,
      'patient_insurance_provider': patientInsuranceProvider,
      'patient_insurance_id': patientInsuranceId,
      'patient_emergency_contact': patientEmergencyContact,
      'patient_medical_history': patientMedicalHistory,
    };
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      fullName: fullName,
      role: _stringToRole(role),
      avatarUrl: avatarUrl,
      phoneNumber: phoneNumber,
      dateOfBirth: dateOfBirth,
      createdAt: createdAt,
      dentistLicenseNumber: dentistLicenseNumber,
      dentistSpecialization: dentistSpecialization,
      dentistYearsExperience: dentistYearsExperience,
      dentistClinicAddress: dentistClinicAddress,
      dentistConsultationFee: dentistConsultationFee,
      patientInsuranceProvider: patientInsuranceProvider,
      patientInsuranceId: patientInsuranceId,
      patientEmergencyContact: patientEmergencyContact,
      patientMedicalHistory: patientMedicalHistory,
    );
  }

  static UserRole _stringToRole(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return UserRole.admin;
      case 'dentist':
        return UserRole.dentist;
      case 'patient':
        return UserRole.patient;
      default:
        return UserRole.unknown;
    }
  }

  @override
  List<Object?> get props => [
    id,
    email,
    fullName,
    role,
    avatarUrl,
    phoneNumber,
    dateOfBirth,
    createdAt,
    updatedAt,
  ];
}