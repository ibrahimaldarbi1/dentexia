import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/failure/failure.dart';
import '../../../shared/domain/entities/appointment_entity.dart';
import '../../../shared/domain/entities/user_entity.dart';
import '../../data/repositories/admin_repository.dart';

part 'admin_providers.g.dart';

// Admin Repository Provider
@riverpod
AdminRepository adminRepository(AdminRepositoryRef ref) {
  throw UnimplementedError('AdminRepository not implemented');
}

// Admin Stats
class AdminStats {
  final int totalUsers;
  final int totalDentists;
  final int totalPatients;
  final int totalAppointments;
  final int pendingAppointments;
  final double monthlyRevenue;
  final List<UserEntity> recentSignups;
  final List<AppointmentEntity> recentAppointments;

  const AdminStats({
    required this.totalUsers,
    required this.totalDentists,
    required this.totalPatients,
    required this.totalAppointments,
    required this.pendingAppointments,
    required this.monthlyRevenue,
    required this.recentSignups,
    required this.recentAppointments,
  });
}

// Admin Stats Provider
@riverpod
Future<AdminStats> adminStats(AdminStatsRef ref) async {
  final repository = ref.watch(adminRepositoryProvider);
  final usersResult = await repository.getAllUsers();
  final appointmentsResult = await repository.getAllAppointments();
  
  return usersResult.fold(
    (failure) => throw failure,
    (users) => appointmentsResult.fold(
      (failure) => throw failure,
      (appointments) {
        final dentists = users.where((u) => u.isDentist).toList();
        final patients = users.where((u) => u.isPatient).toList();
        
        final now = DateTime.now();
        final thisMonthAppointments = appointments.where(
          (a) => a.appointmentDate.year == now.year && 
                 a.appointmentDate.month == now.month
        ).toList();
        
        return AdminStats(
          totalUsers: users.length,
          totalDentists: dentists.length,
          totalPatients: patients.length,
          totalAppointments: appointments.length,
          pendingAppointments: appointments.where((a) => a.status == 'pending').length,
          monthlyRevenue: thisMonthAppointments.fold(0.0, (sum, a) => sum + (a.fee ?? 0)),
          recentSignups: users.take(5).toList(),
          recentAppointments: appointments.take(5).toList(),
        );
      },
    ),
  );
}

// Users List Provider
@riverpod
class AdminUsersNotifier extends _$AdminUsersNotifier {
  @override
  Future<List<UserEntity>> build() async {
    final repository = ref.watch(adminRepositoryProvider);
    final result = await repository.getAllUsers();
    return result.fold(
      (failure) => throw failure,
      (users) => users,
    );
  }

  Future<void> updateUserRole(String userId, UserRole newRole) async {
    state = const AsyncLoading();
    final repository = ref.watch(adminRepositoryProvider);
    final result = await repository.updateUserRole(userId, newRole);
    
    state = await result.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      (_) => build(),
    );
  }

  Future<void> deleteUser(String userId) async {
    state = const AsyncLoading();
    final repository = ref.watch(adminRepositoryProvider);
    final result = await repository.deleteUser(userId);
    
    state = await result.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      (_) => build(),
    );
  }
}

// Appointments Management Provider
@riverpod
class AdminAppointmentsNotifier extends _$AdminAppointmentsNotifier {
  @override
  Future<List<AppointmentEntity>> build() async {
    final repository = ref.watch(adminRepositoryProvider);
    final result = await repository.getAllAppointments();
    return result.fold(
      (failure) => throw failure,
      (appointments) => appointments,
    );
  }

  Future<void> updateAppointmentStatus(
    String appointmentId, 
    String newStatus
  ) async {
    state = const AsyncLoading();
    final repository = ref.watch(adminRepositoryProvider);
    final result = await repository.updateAppointmentStatus(
      appointmentId, 
      newStatus
    );
    
    state = await result.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      (_) => build(),
    );
  }

  Future<void> cancelAppointment(String appointmentId) async {
    state = const AsyncLoading();
    final repository = ref.watch(adminRepositoryProvider);
    final result = await repository.cancelAppointment(appointmentId);
    
    state = await result.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      (_) => build(),
    );
  }
}

// Analytics Provider
@riverpod
class AdminAnalyticsNotifier extends _$AdminAnalyticsNotifier {
  @override
  Future<Map<String, dynamic>> build() async {
    final repository = ref.watch(adminRepositoryProvider);
    final result = await repository.getAnalytics();
    return result.fold(
      (failure) => throw failure,
      (analytics) => analytics,
    );
  }

  Future<Map<String, dynamic>> getRevenueByMonth(int year) async {
    final repository = ref.watch(adminRepositoryProvider);
    final result = await repository.getRevenueByMonth(year);
    return result.fold(
      (failure) => throw failure,
      (revenue) => revenue,
    );
  }
}