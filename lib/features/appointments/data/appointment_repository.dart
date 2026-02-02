import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/providers/supabase_provider.dart';
import '../domain/appointment_entity.dart';
import '../../auth/domain/user_entity.dart';

part 'appointment_repository.g.dart';

class AppointmentRepository {
  final SupabaseClient _supabase;

  AppointmentRepository(this._supabase);

  // 1. Get Appointments for a specific Dentist on a specific Date
  Future<List<AppointmentEntity>> getDentistSchedule(String dentistId, DateTime date) async {
    // Calculate start/end of the day
    final startOfDay = DateTime(date.year, date.month, date.day).toIso8601String();
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59).toIso8601String();

    final response = await _supabase
        .from('appointments')
        .select('*, patient:patient_id(*), service:service_id(name)')
        .eq('dentist_id', dentistId)
        .gte('start_time', startOfDay)
        .lte('start_time', endOfDay)
        .order('start_time', ascending: true);

    return (response as List).map((data) {
      // Map flat JSON to Entity
      final patientData = data['patient'];
      final serviceName = data['service']['name'];
      
      return AppointmentEntity(
        id: data['id'],
        dentistId: data['dentist_id'],
        patientId: data['patient_id'],
        serviceName: serviceName,
        startTime: DateTime.parse(data['start_time']),
        endTime: DateTime.parse(data['end_time']),
        status: data['status'],
        notes: data['notes'],
        patient: patientData != null ? UserEntity.fromJson(patientData) : null,
      );
    }).toList();
  }

  // 2. Update Status
  Future<void> updateStatus(String appointmentId, String newStatus) async {
    await _supabase
        .from('appointments')
        .update({'status': newStatus})
        .eq('id', appointmentId);
  }
}

@Riverpod(keepAlive: true)
AppointmentRepository appointmentRepository(AppointmentRepositoryRef ref) {
  return AppointmentRepository(ref.watch(supabaseClientProvider));
}