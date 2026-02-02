import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';
part 'user_entity.g.dart';

enum UserRole {
  admin,
  dentist,
  patient,
  staff;
  
  // Helper to parse string from DB
  static UserRole fromString(String role) => 
      UserRole.values.firstWhere((e) => e.name == role, orElse: () => UserRole.patient);
}

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String id,
    required String email,
    required UserRole role,
    String? firstName,
    String? lastName,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);
}