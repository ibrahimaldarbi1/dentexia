import 'package:equatable/equatable.dart';

class AppointmentEntity extends Equatable {
  final String id;
  final String patientId;
  final String patientName;
  final String dentistId;
  final String dentistName;
  final DateTime appointmentDate;
  final String appointmentTime;
  final int durationMinutes;
  final String status; // scheduled, confirmed, completed, cancelled, no_show
  final String? reason;
  final String? notes;
  final double? fee;
  final String? treatmentType;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  const AppointmentEntity({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.dentistId,
    required this.dentistName,
    required this.appointmentDate,
    required this.appointmentTime,
    this.durationMinutes = 30,
    required this.status,
    this.reason,
    this.notes,
    this.fee,
    this.treatmentType,
    required this.createdAt,
    required this.updatedAt,
  });
  
  bool get isUpcoming => 
      appointmentDate.isAfter(DateTime.now()) && 
      status != 'cancelled' && 
      status != 'completed';
  
  bool get isToday => 
      appointmentDate.year == DateTime.now().year &&
      appointmentDate.month == DateTime.now().month &&
      appointmentDate.day == DateTime.now().day;
  
  @override
  List<Object?> get props => [
    id,
    patientId,
    dentistId,
    appointmentDate,
    status,
  ];
}