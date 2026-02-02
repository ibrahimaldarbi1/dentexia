// lib/features/auth/presentation/providers/auth_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../states/auth_state.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_providers.g.dart';

// Provider for AuthRepository
@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return AuthRepositoryImpl(
    remoteDataSource: AuthRemoteDataSourceImpl(supabaseClient: supabaseClient),
  );
}

// Provider for SignInUseCase
@riverpod
SignInUseCase signInUseCase(SignInUseCaseRef ref) {
  final repository = ref.watch(authRepositoryProvider);
  return SignInUseCase(repository: repository);
}

// State notifier for auth state
@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() {
    // Check initial auth state
    _checkInitialAuth();
    return const AuthState.initial();
  }

  Future<void> _checkInitialAuth() async {
    final repository = ref.read(authRepositoryProvider);
    final result = await repository.getCurrentUser();
    
    result.fold(
      (failure) => state = AuthState.unauthenticated(failure.message),
      (user) {
        if (user != null) {
          state = AuthState.authenticated(user);
        } else {
          state = const AuthState.unauthenticated();
        }
      },
    );
  }

  Future<void> signIn(String email, String password) async {
    state = const AuthState.loading();
    
    final useCase = ref.read(signInUseCaseProvider);
    final result = await useCase.call(email: email, password: password);
    
    result.fold(
      (failure) => state = AuthState.error(failure.message),
      (user) => state = AuthState.authenticated(user),
    );
  }

  Future<void> signOut() async {
    state = const AuthState.loading();
    
    final repository = ref.read(authRepositoryProvider);
    final result = await repository.signOut();
    
    result.fold(
      (failure) => state = AuthState.error(failure.message),
      (_) => state = const AuthState.unauthenticated(),
    );
  }
}