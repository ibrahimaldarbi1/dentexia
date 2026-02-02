import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../appointments/presentation/controllers/dentist_schedule_controller.dart';
import '../../appointments/domain/appointment_entity.dart';
import '../../auth/presentation/auth_controller.dart';

class DentistDashboardScreen extends ConsumerStatefulWidget {
  const DentistDashboardScreen({super.key});

  @override
  ConsumerState<DentistDashboardScreen> createState() => _DentistDashboardScreenState();
}

class _DentistDashboardScreenState extends ConsumerState<DentistDashboardScreen> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // Watch the specific provider family with the selected date
    final scheduleAsync = ref.watch(dentistScheduleControllerProvider(_selectedDate));

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Schedule"),
        actions: [
           IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authControllerProvider.notifier).logout(),
          )
        ],
      ),
      body: Column(
        children: [
          _buildDateSelector(),
          Expanded(
            child: scheduleAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text("Error: $err")),
              data: (appointments) {
                if (appointments.isEmpty) {
                  return const Center(child: Text("No appointments for today."));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: appointments.length,
                  itemBuilder: (context, index) {
                    return _AppointmentCard(appointment: appointments[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.blue.withOpacity(0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => setState(() => _selectedDate = _selectedDate.subtract(const Duration(days: 1))),
          ),
          Text(
            DateFormat('EEEE, MMM d').format(_selectedDate),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: () => setState(() => _selectedDate = _selectedDate.add(const Duration(days: 1))),
          ),
        ],
      ),
    );
  }
}

class _AppointmentCard extends ConsumerWidget {
  final AppointmentEntity appointment;

  const _AppointmentCard({required this.appointment});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Color statusColor = _getStatusColor(appointment.status);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${DateFormat('HH:mm').format(appointment.startTime)} - ${DateFormat('HH:mm').format(appointment.endTime)}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Chip(
                  label: Text(appointment.status.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 10)),
                  backgroundColor: statusColor,
                )
              ],
            ),
            const SizedBox(height: 8),
            Text(
              appointment.patient != null 
                  ? "${appointment.patient!.firstName} ${appointment.patient!.lastName}" 
                  : "Unknown Patient",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(
              appointment.serviceName,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const Divider(),
            if (appointment.status != 'completed' && appointment.status != 'cancelled')
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      // Call controller to update status
                      ref.read(dentistScheduleControllerProvider(appointment.startTime).notifier)
                         .updateStatus(appointment.id, 'cancelled');
                    },
                    child: const Text("Cancel", style: TextStyle(color: Colors.red)),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(dentistScheduleControllerProvider(appointment.startTime).notifier)
                         .updateStatus(appointment.id, 'completed');
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text("Complete", style: TextStyle(color: Colors.white)),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'confirmed': return Colors.blue;
      case 'completed': return Colors.green;
      case 'cancelled': return Colors.red;
      default: return Colors.orange;
    }
  }
}