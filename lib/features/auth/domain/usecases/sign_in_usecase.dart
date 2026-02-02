import 'package:fpdart/fpdart.dart';
import '../repositories/auth_repository.dart';
import '../../../../core/failure/failure.dart';
import '../entities/user_entity.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase({required this.repository});

  Future<Either<Failure, UserEntity>> call({
    required String email,
    required String password,
  }) {
    return repository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}