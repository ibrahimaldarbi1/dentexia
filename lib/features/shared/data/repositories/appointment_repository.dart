import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/failure/failure.dart';
import '../models/appointment_model.dart';

abstract class AppointmentRepository {
  FutureEither<List<AppointmentModel>> getAppointments({
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    String? userId,
    String? userRole,
  });
  
  FutureEither<AppointmentModel> createAppointment(Map<String, dynamic> data);
  FutureEither<AppointmentModel> updateAppointment(String id, Map<String, dynamic> data);
  FutureEither<void> cancelAppointment(String id, String reason);
  FutureEither<void> confirmAppointment(String id);
  
  Stream<List<AppointmentModel>> watchAppointments(String userId);
  
  FutureEither<List<Map<String, dynamic>>> getAvailableSlots(
    String dentistId, 
    DateTime date
  );
  
  FutureEither<List<Map<String, dynamic>>> getAppointmentStats(String userId);
}