import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/providers/supabase_provider.dart';
import '../../auth/domain/user_entity.dart';

part 'admin_repository.g.dart';

class AdminRepository {
  final SupabaseClient _supabase;

  AdminRepository(this._supabase);

  // 1. Fetch all users (profiles)
  Future<List<UserEntity>> getAllUsers() async {
    final data = await _supabase
        .from('profiles')
        .select()
        .order('created_at', ascending: false);

    return (data as List).map((json) => UserEntity.fromJson(json)).toList();
  }

  // 2. Create a new User (Dentist/Staff)
  Future<void> createUser({
    required String email,
    required String password,
    required UserRole role,
    required String firstName,
    required String lastName,
  }) async {
    await _supabase.rpc('create_user_by_admin', params: {
      'email': email,
      'password': password,
      'role': role.name,
      'first_name': firstName,
      'last_name': lastName,
    });
  }
}

@Riverpod(keepAlive: true)
AdminRepository adminRepository(AdminRepositoryRef ref) {
  return AdminRepository(ref.watch(supabaseClientProvider));
}