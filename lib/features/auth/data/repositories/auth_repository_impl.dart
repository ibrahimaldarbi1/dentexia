// lib/features/auth/data/repositories/auth_repository_impl.dart
import 'package:fpdart/fpdart.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user_entity.dart';
import '../datasources/auth_remote_data_source.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/utils/either_extensions.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  FutureEither<UserEntity> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return tryCatchAsync(
      () async {
        final user = await remoteDataSource.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        
        if (user == null) {
          throw InvalidCredentialsFailure();
        }
        
        return user;
      },
      onError: (error, stackTrace) {
        if (error is InvalidCredentialsFailure) {
          return error;
        }
        return AuthFailure(message: error.toString(), stackTrace: stackTrace);
      },
    );
  }

  @override
  FutureEither<UserEntity> signUp({
    required String email,
    required String password,
    required String fullName,
    required UserRole role,
    Map<String, dynamic>? additionalData,
  }) async {
    return tryCatchAsync(
      () async {
        final user = await remoteDataSource.signUp(
          email: email,
          password: password,
          fullName: fullName,
          role: role,
          additionalData: additionalData,
        );
        
        if (user == null) {
          throw AuthFailure(message: 'Failed to create user');
        }
        
        return user;
      },
      onError: (error, stackTrace) {
        if (error is AuthFailure) {
          return error;
        }
        return AuthFailure(message: error.toString(), stackTrace: stackTrace);
      },
    );
  }

  @override
  FutureEither<void> signOut() async {
    return tryCatchAsync(
      () async {
        await remoteDataSource.signOut();
      },
      onError: (error, stackTrace) {
        return AuthFailure(message: error.toString(), stackTrace: stackTrace);
      },
    );
  }

  @override
  FutureEither<UserEntity?> getCurrentUser() async {
    return tryCatchAsync(
      () async {
        return await remoteDataSource.getCurrentUser();
      },
      onError: (error, stackTrace) {
        return DatabaseFailure(message: error.toString(), stackTrace: stackTrace);
      },
    );
  }

  @override
  FutureEither<void> updateProfile(Map<String, dynamic> data) async {
    return tryCatchAsync(
      () async {
        await remoteDataSource.updateProfile(data);
      },
      onError: (error, stackTrace) {
        return DatabaseFailure(message: error.toString(), stackTrace: stackTrace);
      },
    );
  }

  @override
  FutureEither<void> resetPassword(String email) async {
    return tryCatchAsync(
      () async {
        // Implement password reset with Supabase
        // await remoteDataSource.resetPassword(email);
        throw UnimplementedError('resetPassword not implemented');
      },
      onError: (error, stackTrace) {
        return AuthFailure(message: error.toString(), stackTrace: stackTrace);
      },
    );
  }
}