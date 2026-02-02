import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'controllers/booking_controller.dart';

class BookingScreen extends ConsumerWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingStateAsync = ref.watch(bookingControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("New Appointment")),
      body: bookingStateAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, st) => Center(child: Text("Error: $err")),
        data: (state) {
          return Stepper(
            currentStep: _getCurrentStep(state),
            onStepTapped: (index) {}, // Optional: allow jumping back
            controlsBuilder: (context, details) => const SizedBox.shrink(), // Hide default buttons
            steps: [
              // Step 1: Service
              Step(
                title: const Text("Select Treatment"),
                content: Column(
                  children: state.services.map((service) => RadioListTile(
                    title: Text(service.name),
                    subtitle: Text("${service.durationMinutes} mins - \$${service.price}"),
                    value: service,
                    groupValue: state.selectedService,
                    onChanged: (val) => ref.read(bookingControllerProvider.notifier).selectService(val!),
                  )).toList(),
                ),
                isActive: _getCurrentStep(state) >= 0,
              ),
              
              // Step 2: Dentist
              Step(
                title: const Text("Select Dentist"),
                content: state.selectedService == null ? const Text("Please select a treatment first.") : 
                  Column(
                    children: state.dentists.map((dentist) => RadioListTile(
                      title: Text("Dr. ${dentist.firstName} ${dentist.lastName}"),
                      value: dentist,
                      groupValue: state.selectedDentist,
                      onChanged: (val) => ref.read(bookingControllerProvider.notifier).selectDentist(val!),
                    )).toList(),
                  ),
                isActive: _getCurrentStep(state) >= 1,
              ),

              // Step 3: Date
              Step(
                title: const Text("Select Date"),
                content: state.selectedDentist == null ? const Text("Select a dentist first.") :
                  CalendarDatePicker(
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 30)),
                    onDateChanged: (date) => ref.read(bookingControllerProvider.notifier).selectDate(date),
                  ),
                isActive: _getCurrentStep(state) >= 2,
              ),

              // Step 4: Time Slot
              Step(
                title: const Text("Available Slots"),
                content: state.selectedDate == null ? const Text("Select a date.") :
                  state.availableSlots.isEmpty 
                    ? const Text("No slots available for this date.", style: TextStyle(color: Colors.red))
                    : Wrap(
                        spacing: 8,
                        children: state.availableSlots.map((slot) => ActionChip(
                          label: Text(DateFormat('HH:mm').format(slot)),
                          onPressed: () async {
                            // Confirm Booking
                            await ref.read(bookingControllerProvider.notifier).confirmBooking(slot);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Booking Confirmed!")));
                              context.pop(); // Go back to dashboard
                            }
                          },
                        )).toList(),
                      ),
                isActive: _getCurrentStep(state) >= 3,
              ),
            ],
          );
        },
      ),
    );
  }

  int _getCurrentStep(BookingState state) {
    if (state.selectedService == null) return 0;
    if (state.selectedDentist == null) return 1;
    if (state.selectedDate == null) return 2;
    return 3;
  }
}