import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/responsive_layout.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../providers/dentist_providers.dart';

class DentistDashboardScreen extends ConsumerWidget {
  const DentistDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todaysAppointmentsAsync = ref.watch(todaysAppointmentsProvider);
    final upcomingAppointmentsAsync = ref.watch(upcomingAppointmentsProvider);
    
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Dentist Dashboard',
        actions: [
          IconButton(
            onPressed: () => _showScheduleSettings(context, ref),
            icon: const Icon(Icons.schedule),
          ),
          IconButton(
            onPressed: () => _showNotifications(context),
            icon: Badge(
              child: const Icon(Icons.notifications),
            ),
          ),
        ],
      ),
      body: todaysAppointmentsAsync.when(
        data: (todaysAppointments) => upcomingAppointmentsAsync.when(
          data: (upcomingAppointments) => ResponsiveLayout(
            mobile: _MobileDentistDashboard(
              todaysAppointments: todaysAppointments,
              upcomingAppointments: upcomingAppointments,
            ),
            tablet: _TabletDentistDashboard(
              todaysAppointments: todaysAppointments,
              upcomingAppointments: upcomingAppointments,
            ),
            desktop: _DesktopDentistDashboard(
              todaysAppointments: todaysAppointments,
              upcomingAppointments: upcomingAppointments,
            ),
          ),
          loading: () => const LoadingIndicator(),
          error: (error, stack) => _buildErrorWidget(context, error),
        ),
        loading: () => const LoadingIndicator(),
        error: (error, stack) => _buildErrorWidget(context, error),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewAppointment(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _MobileDentistDashboard extends StatelessWidget {
  final List<AppointmentEntity> todaysAppointments;
  final List<AppointmentEntity> upcomingAppointments;

  const _MobileDentistDashboard({
    required this.todaysAppointments,
    required this.upcomingAppointments,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildWelcomeCard(context),
          const SizedBox(height: 20),
          _buildTodaysAppointments(context, todaysAppointments),
          const SizedBox(height: 20),
          _buildUpcomingAppointments(context, upcomingAppointments),
          const SizedBox(height: 20),
          _buildQuickStats(context),
        ],
      ),
    );
  }
}

class _DesktopDentistDashboard extends ConsumerWidget {
  final List<AppointmentEntity> todaysAppointments;
  final List<AppointmentEntity> upcomingAppointments;

  const _DesktopDentistDashboard({
    required this.todaysAppointments,
    required this.upcomingAppointments,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientsAsync = ref.watch(dentistPatientsProvider);
    
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Column - Calendar & Quick Actions
          Expanded(
            flex: 2,
            child: Column(
              children: [
                _buildCalendarView(context),
                const SizedBox(height: 24),
                _buildQuickActions(context),
              ],
            ),
          ),
          
          const SizedBox(width: 24),
          
          // Right Column - Appointments & Patients
          Expanded(
            flex: 3,
            child: Column(
              children: [
                _buildWelcomeCard(context),
                const SizedBox(height: 24),
                _buildAppointmentsSection(
                  context, 
                  todaysAppointments, 
                  upcomingAppointments
                ),
                const SizedBox(height: 24),
                patientsAsync.when(
                  data: (patients) => _buildPatientsList(context, patients),
                  loading: () => const CircularProgressIndicator(),
                  error: (error, stack) => const SizedBox(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildWelcomeCard(BuildContext context) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.dentistColor.withOpacity(0.1),
            child: Icon(
              Icons.medical_services,
              size: 30,
              color: AppColors.dentistColor,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good morning, Dr. Smith',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'You have 5 appointments today',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildTodaysAppointments(
  BuildContext context, 
  List<AppointmentEntity> appointments
) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today's Appointments",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Chip(
                label: Text('${appointments.length}'),
                backgroundColor: AppColors.dentistColor.withOpacity(0.1),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...appointments.take(3).map((appointment) => AppointmentTile(
            appointment: appointment,
            onTap: () => _viewAppointmentDetails(context, appointment),
          )),
          if (appointments.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'No appointments scheduled for today',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
        ],
      ),
    ),
  );
}

Widget _buildCalendarView(BuildContext context) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Schedule',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 400,
            child: SfCalendar(
              view: CalendarView.week,
              dataSource: _getCalendarDataSource(),
              monthViewSettings: const MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
              ),
              onTap: (calendarTapDetails) {
                // Handle calendar tap
              },
            ),
          ),
        ],
      ),
    ),
  );
}

class AppointmentTile extends StatelessWidget {
  final AppointmentEntity appointment;
  final VoidCallback onTap;

  const AppointmentTile({
    required this.appointment,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: _getStatusColor(appointment.status),
        child: Icon(
          _getAppointmentIcon(appointment.status),
          size: 16,
          color: Colors.white,
        ),
      ),
      title: Text(appointment.patientName),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${_formatTime(appointment.appointmentTime)} - ${appointment.reason ?? "Checkup"}'),
          Text(
            appointment.status,
            style: TextStyle(
              color: _getStatusColor(appointment.status),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

String _formatTime(String time) {
  try {
    final parsedTime = DateFormat('HH:mm').parse(time);
    return DateFormat('h:mm a').format(parsedTime);
  } catch (e) {
    return time;
  }
}

// Helper methods and other widgets...