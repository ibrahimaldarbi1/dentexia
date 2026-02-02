import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/user_entity.dart';

abstract class AuthRemoteDataSource {
  Future<UserEntity?> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  
  Future<UserEntity?> signUp({
    required String email,
    required String password,
    required String fullName,
    required UserRole role,
    Map<String, dynamic>? additionalData,
  });
  
  Future<void> signOut();
  
  Future<UserEntity?> getCurrentUser();
  
  Future<void> updateProfile(Map<String, dynamic> data);
  
  Stream<User?> get authStateChanges;
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<UserEntity?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final response = await supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
    
    if (response.user == null) return null;
    
    return await _fetchUserProfile(response.user!.id);
  }

  Future<UserEntity?> _fetchUserProfile(String userId) async {
    final response = await supabaseClient
        .from('user_profiles')
        .select()
        .eq('id', userId)
        .single()
        .execute();
    
    if (response.error != null) return null;
    
    return UserEntity.fromJson(response.data);
  }

  @override
  Stream<User?> get authStateChanges => supabaseClient.auth.onAuthStateChange;
}