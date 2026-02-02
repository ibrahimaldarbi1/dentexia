import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/providers/supabase_provider.dart';
import '../../auth/domain/user_entity.dart';
import '../../appointments/domain/appointment_entity.dart';

part 'patient_repository.g.dart';

// Simple model for Service
class ServiceEntity {
  final String id;
  final String name;
  final int durationMinutes;
  final double price;

  ServiceEntity({required this.id, required this.name, required this.durationMinutes, required this.price});

  factory ServiceEntity.fromJson(Map<String, dynamic> json) {
    return ServiceEntity(
      id: json['id'],
      name: json['name'],
      durationMinutes: json['duration_minutes'],
      price: (json['price'] as num).toDouble(),
    );
  }
}

class PatientRepository {
  final SupabaseClient _supabase;

  PatientRepository(this._supabase);

  // 1. Get All Services
  Future<List<ServiceEntity>> getServices() async {
    final data = await _supabase.from('services').select().eq('is_active', true);
    return (data as List).map((e) => ServiceEntity.fromJson(e)).toList();
  }

  // 2. Get All Dentists
  Future<List<UserEntity>> getDentists() async {
    final data = await _supabase.from('profiles').select().eq('role', 'dentist');
    return (data as List).map((e) => UserEntity.fromJson(e)).toList();
  }

  // 3. Get Booked Slots for a Dentist on a Date
  Future<List<DateTime>> getBookedStartTimes(String dentistId, DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day).toIso8601String();
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59).toIso8601String();

    final response = await _supabase
        .from('appointments')
        .select('start_time, end_time') // We only need times
        .eq('dentist_id', dentistId)
        .neq('status', 'cancelled') // Ignore cancelled
        .gte('start_time', startOfDay)
        .lte('start_time', endOfDay);

    // Return list of start times that are already taken
    return (response as List).map((e) => DateTime.parse(e['start_time'])).toList();
  }

  // 4. Create Appointment
  Future<void> createAppointment({
    required String dentistId,
    required String patientId,
    required String serviceId,
    required DateTime startTime,
    required int durationMinutes,
  }) async {
    final endTime = startTime.add(Duration(minutes: durationMinutes));
    
    await _supabase.from('appointments').insert({
      'dentist_id': dentistId,
      'patient_id': patientId,
      'service_id': serviceId,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'status': 'pending',
    });
  }
}

@Riverpod(keepAlive: true)
PatientRepository patientRepository(PatientRepositoryRef ref) {
  return PatientRepository(ref.watch(supabaseClientProvider));
}