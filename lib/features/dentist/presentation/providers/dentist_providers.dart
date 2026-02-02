import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/failure/failure.dart';
import '../../../shared/domain/entities/appointment_entity.dart';
import '../../../shared/domain/entities/patient_entity.dart';
import '../../data/repositories/dentist_repository.dart';

part 'dentist_providers.g.dart';

// Dentist Repository Provider
@riverpod
DentistRepository dentistRepository(DentistRepositoryRef ref) {
  throw UnimplementedError('DentistRepository not implemented');
}

// Today's Appointments Provider
@riverpod
Future<List<AppointmentEntity>> todaysAppointments(TodaysAppointmentsRef ref) async {
  final repository = ref.watch(dentistRepositoryProvider);
  final result = await repository.getTodaysAppointments();
  return result.fold(
    (failure) => throw failure,
    (appointments) => appointments,
  );
}

// Upcoming Appointments Provider
@riverpod
Future<List<AppointmentEntity>> upcomingAppointments(UpcomingAppointmentsRef ref) async {
  final repository = ref.watch(dentistRepositoryProvider);
  final result = await repository.getUpcomingAppointments();
  return result.fold(
    (failure) => throw failure,
    (appointments) => appointments,
  );
}

// Patient List Provider
@riverpod
Future<List<PatientEntity>> dentistPatients(DentistPatientsRef ref) async {
  final repository = ref.watch(dentistRepositoryProvider);
  final result = await repository.getMyPatients();
  return result.fold(
    (failure) => throw failure,
    (patients) => patients,
  );
}

// Schedule Provider
@riverpod
class DentistScheduleNotifier extends _$DentistScheduleNotifier {
  @override
  Future<Map<String, dynamic>> build() async {
    final repository = ref.watch(dentistRepositoryProvider);
    final result = await repository.getSchedule();
    return result.fold(
      (failure) => throw failure,
      (schedule) => schedule,
    );
  }

  Future<void> updateAvailability(Map<String, bool> availability) async {
    state = const AsyncLoading();
    final repository = ref.watch(dentistRepositoryProvider);
    final result = await repository.updateAvailability(availability);
    
    state = await result.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      (_) => build(),
    );
  }

  Future<void> addTimeOff(DateTime startDate, DateTime endDate, String reason) async {
    state = const AsyncLoading();
    final repository = ref.watch(dentistRepositoryProvider);
    final result = await repository.addTimeOff(startDate, endDate, reason);
    
    state = await result.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      (_) => build(),
    );
  }
}

// Treatment Plans Provider
@riverpod
class TreatmentPlansNotifier extends _$TreatmentPlansNotifier {
  @override
  Future<List<Map<String, dynamic>>> build() async {
    final repository = ref.watch(dentistRepositoryProvider);
    final result = await repository.getTreatmentPlans();
    return result.fold(
      (failure) => throw failure,
      (plans) => plans,
    );
  }

  Future<void> createTreatmentPlan(Map<String, dynamic> plan) async {
    state = const AsyncLoading();
    final repository = ref.watch(dentistRepositoryProvider);
    final result = await repository.createTreatmentPlan(plan);
    
    state = await result.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      (_) => build(),
    );
  }

  Future<void> updateTreatmentPlan(String planId, Map<String, dynamic> updates) async {
    state = const AsyncLoading();
    final repository = ref.watch(dentistRepositoryProvider);
    final result = await repository.updateTreatmentPlan(planId, updates);
    
    state = await result.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      (_) => build(),
    );
  }
}

// Dental Records Provider
@riverpod
Future<List<Map<String, dynamic>>> patientRecords(
  PatientRecordsRef ref, 
  String patientId
) async {
  final repository = ref.watch(dentistRepositoryProvider);
  final result = await repository.getPatientRecords(patientId);
  return result.fold(
    (failure) => throw failure,
    (records) => records,
  );
}

// Real-time appointment updates
@riverpod
Stream<List<AppointmentEntity>> realtimeAppointments(RealtimeAppointmentsRef ref) {
  final repository = ref.watch(dentistRepositoryProvider);
  return repository.watchAppointments();
}