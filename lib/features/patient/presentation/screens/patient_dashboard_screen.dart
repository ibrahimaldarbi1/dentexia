import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/responsive_layout.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class PatientDashboardScreen extends ConsumerWidget {
  const PatientDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My Dental Care',
        actions: [
          IconButton(
            onPressed: () => _showNotifications(context),
            icon: Badge(
              label: const Text('3'),
              child: const Icon(Icons.notifications),
            ),
          ),
        ],
      ),
      body: ResponsiveLayout(
        mobile: const _MobilePatientDashboard(),
        tablet: const _TabletPatientDashboard(),
        desktop: const _DesktopPatientDashboard(),
      ),
    );
  }
}

class _MobilePatientDashboard extends StatelessWidget {
  const _MobilePatientDashboard();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildWelcomeCard(context),
          const SizedBox(height: 20),
          _buildNextAppointment(context),
          const SizedBox(height: 20),
          _buildHealthMetrics(context),
          const SizedBox(height: 20),
          _buildQuickActions(context),
          const SizedBox(height: 20),
          _buildDentalHistory(context),
        ],
      ),
    );
  }
}

Widget _buildWelcomeCard(BuildContext context) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.patientColor.withOpacity(0.1),
                child: Icon(
                  Icons.person,
                  size: 30,
                  color: AppColors.patientColor,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back, John!',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Your dental health is important',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const LinearProgressIndicator(
            value: 0.75,
            backgroundColor: Colors.grey,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.patientColor),
          ),
          const SizedBox(height: 8),
          const Text(
            'Next checkup in 30 days',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    ),
  );
}