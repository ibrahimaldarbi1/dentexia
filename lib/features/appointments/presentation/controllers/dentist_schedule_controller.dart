import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/appointment_entity.dart';
import '../../data/appointment_repository.dart';
import '../../../auth/presentation/auth_controller.dart';

part 'dentist_schedule_controller.g.dart';

@riverpod
class DentistScheduleController extends _$DentistScheduleController {
  @override
  FutureOr<List<AppointmentEntity>> build(DateTime date) async {
    final user = ref.read(authControllerProvider).valueOrNull;
    if (user == null) throw Exception("User not logged in");

    return ref.read(appointmentRepositoryProvider).getDentistSchedule(user.id, date);
  }

  Future<void> updateStatus(String appointmentId, String status) async {
    // Optimistic update could go here, but for simplicity we refresh
    await ref.read(appointmentRepositoryProvider).updateStatus(appointmentId, status);
    ref.invalidateSelf();
  }
}