import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// Reuse the AppointmentRepository to fetch patient's own list
// (Implementation similar to Dentist Dashboard but filtering by patient_id)

class PatientDashboardScreen extends ConsumerWidget {
  const PatientDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Health")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.calendar_month, size: 80, color: Colors.blue),
            const SizedBox(height: 20),
            const Text("No upcoming appointments"),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text("Book Appointment"),
              onPressed: () => context.push('/patient-dashboard/book'),
            )
          ],
        ),
      ),
    );
  }
}