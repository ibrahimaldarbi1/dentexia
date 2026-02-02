// lib/features/auth/domain/repositories/auth_repository.dart
import 'package:fpdart/fpdart.dart';
import '../entities/user_entity.dart';
import '../../../../core/failure/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  
  Future<Either<Failure, UserEntity>> signUp({
    required String email,
    required String password,
    required String fullName,
    required UserRole role,
    Map<String, dynamic>? additionalData,
  });
  
  Future<Either<Failure, void>> signOut();
  
  Future<Either<Failure, UserEntity?>> getCurrentUser();
  
  Future<Either<Failure, void>> updateProfile(Map<String, dynamic> data);
  
  Future<Either<Failure, void>> resetPassword(String email);
}