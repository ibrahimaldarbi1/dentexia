// lib/features/admin/data/repositories/admin_repository.dart
import 'package:fpdart/fpdart.dart';
import '../../../../core/failure/failure.dart';
import '../../../shared/domain/entities/appointment_entity.dart';
import '../../../shared/domain/entities/user_entity.dart';

abstract class AdminRepository {
  FutureEither<List<UserEntity>> getAllUsers();
  FutureEither<void> updateUserRole(String userId, UserRole newRole);
  FutureEither<void> deleteUser(String userId);
  
  FutureEither<List<AppointmentEntity>> getAllAppointments();
  FutureEither<void> updateAppointmentStatus(String appointmentId, String newStatus);
  FutureEither<void> cancelAppointment(String appointmentId);
  
  FutureEither<Map<String, dynamic>> getAnalytics();
  FutureEither<Map<String, dynamic>> getRevenueByMonth(int year);
  
  FutureEither<void> sendBroadcastNotification(String title, String message);
  FutureEither<void> updateSystemSettings(Map<String, dynamic> settings);
}