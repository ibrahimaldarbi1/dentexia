import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../auth/domain/user_entity.dart';
import '../../data/admin_repository.dart';

part 'user_management_controller.g.dart';

@riverpod
class UserManagementController extends _$UserManagementController {
  @override
  FutureOr<List<UserEntity>> build() {
    return ref.read(adminRepositoryProvider).getAllUsers();
  }

  Future<void> addUser({
    required String email,
    required String password,
    required UserRole role,
    required String firstName,
    required String lastName,
  }) async {
    state = const AsyncLoading();
    try {
      await ref.read(adminRepositoryProvider).createUser(
            email: email,
            password: password,
            role: role,
            firstName: firstName,
            lastName: lastName,
          );
      // Refresh list after success
      ref.invalidateSelf(); 
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}