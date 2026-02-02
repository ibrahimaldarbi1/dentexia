import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/patient_repository.dart';
import '../../../auth/presentation/auth_controller.dart';
import '../../../auth/domain/user_entity.dart';
part 'booking_controller.g.dart';

// State to hold the Booking Wizard data
class BookingState {
  final List<ServiceEntity> services;
  final List<UserEntity> dentists;
  final ServiceEntity? selectedService;
  final UserEntity? selectedDentist;
  final DateTime? selectedDate;
  final List<DateTime> availableSlots;

  BookingState({
    this.services = const [],
    this.dentists = const [],
    this.selectedService,
    this.selectedDentist,
    this.selectedDate,
    this.availableSlots = const [],
  });

  BookingState copyWith({
    List<ServiceEntity>? services,
    List<UserEntity>? dentists,
    ServiceEntity? selectedService,
    UserEntity? selectedDentist,
    DateTime? selectedDate,
    List<DateTime>? availableSlots,
  }) {
    return BookingState(
      services: services ?? this.services,
      dentists: dentists ?? this.dentists,
      selectedService: selectedService ?? this.selectedService,
      selectedDentist: selectedDentist ?? this.selectedDentist,
      selectedDate: selectedDate ?? this.selectedDate,
      availableSlots: availableSlots ?? this.availableSlots,
    );
  }
}

@riverpod
class BookingController extends _$BookingController {
  @override
  FutureOr<BookingState> build() async {
    // Initial Load: Get lists
    final repo = ref.read(patientRepositoryProvider);
    final services = await repo.getServices();
    final dentists = await repo.getDentists();
    
    return BookingState(services: services, dentists: dentists);
  }

  void selectService(ServiceEntity service) {
    state = AsyncData(state.value!.copyWith(selectedService: service));
    _calculateSlots();
  }

  void selectDentist(UserEntity dentist) {
    state = AsyncData(state.value!.copyWith(selectedDentist: dentist));
    _calculateSlots();
  }

  void selectDate(DateTime date) {
    state = AsyncData(state.value!.copyWith(selectedDate: date));
    _calculateSlots();
  }

  // CORE LOGIC: Find free slots
  Future<void> _calculateSlots() async {
    final currentState = state.value!;
    if (currentState.selectedService == null || 
        currentState.selectedDentist == null || 
        currentState.selectedDate == null) {
      return;
    }

    // 1. Fetch existing bookings
    final bookedStarts = await ref.read(patientRepositoryProvider)
        .getBookedStartTimes(currentState.selectedDentist!.id, currentState.selectedDate!);

    // 2. Define Working Hours (e.g., 9 AM to 5 PM)
    final workStart = DateTime(
      currentState.selectedDate!.year, 
      currentState.selectedDate!.month, 
      currentState.selectedDate!.day, 
      9, 0 // 09:00 AM
    );
    final workEnd = DateTime(
      currentState.selectedDate!.year, 
      currentState.selectedDate!.month, 
      currentState.selectedDate!.day, 
      17, 0 // 05:00 PM
    );

    // 3. Generate Slots
    List<DateTime> validSlots = [];
    DateTime currentSlot = workStart;
    final duration = Duration(minutes: currentState.selectedService!.durationMinutes);

    while (currentSlot.add(duration).isBefore(workEnd) || currentSlot.add(duration).isAtSameMomentAs(workEnd)) {
      // Check collision
      // Simple check: Is this exact start time already taken?
      // (For a real production app, you check range overlaps, but this suffices for fixed slots)
      bool isTaken = bookedStarts.any((booked) => booked.isAtSameMomentAs(currentSlot));

      if (!isTaken) {
        validSlots.add(currentSlot);
      }

      currentSlot = currentSlot.add(duration);
    }

    state = AsyncData(currentState.copyWith(availableSlots: validSlots));
  }

  Future<void> confirmBooking(DateTime slotTime) async {
    final s = state.value!;
    final user = ref.read(authControllerProvider).valueOrNull!;
    
    await ref.read(patientRepositoryProvider).createAppointment(
      dentistId: s.selectedDentist!.id,
      patientId: user.id,
      serviceId: s.selectedService!.id,
      startTime: slotTime,
      durationMinutes: s.selectedService!.durationMinutes,
    );
  }
}