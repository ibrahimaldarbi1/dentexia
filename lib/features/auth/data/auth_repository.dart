import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/providers/supabase_provider.dart';
import '../domain/user_entity.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  final SupabaseClient _supabase;

  AuthRepository(this._supabase);

  // 1. Login & Fetch Profile
  Future<UserEntity> login(String email, String password) async {
    final response = await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.user == null) {
      throw Exception('Login failed: User is null');
    }

    // Fetch extra profile data (Role)
    final profileData = await _supabase
        .from('profiles')
        .select()
        .eq('id', response.user!.id)
        .single();

    return UserEntity(
      id: response.user!.id,
      email: response.user!.email!,
      role: UserRole.fromString(profileData['role']),
      firstName: profileData['first_name'],
      lastName: profileData['last_name'],
    );
  }

  // 2. Sign Out
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  // 3. Get Current Session User (for App Start)
  Future<UserEntity?> getCurrentUser() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return null;

    try {
      final profileData = await _supabase
          .from('profiles')
          .select()
          .eq('id', user.id)
          .single();
          
      return UserEntity(
        id: user.id,
        email: user.email!,
        role: UserRole.fromString(profileData['role']),
        firstName: profileData['first_name'],
        lastName: profileData['last_name'],
      );
    } catch (e) {
      // If profile fetch fails, force logout or return basic user
      return null;
    }
  }
}

// Provider definition
@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(ref.watch(supabaseClientProvider));
}