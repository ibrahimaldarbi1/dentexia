import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/responsive_layout.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../providers/admin_providers.dart';
import 'admin_users_screen.dart';
import 'admin_appointments_screen.dart';

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(adminStatsProvider);
    
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Admin Dashboard',
        actions: [
          IconButton(
            onPressed: () => ref.read(themeProvider.notifier).toggleTheme(),
            icon: const Icon(Icons.brightness_6),
          ),
          IconButton(
            onPressed: () => _showNotifications(context),
            icon: Badge(
              child: const Icon(Icons.notifications),
            ),
          ),
        ],
      ),
      body: statsAsync.when(
        data: (stats) => ResponsiveLayout(
          mobile: _MobileAdminDashboard(stats: stats),
          tablet: _TabletAdminDashboard(stats: stats),
          desktop: _DesktopAdminDashboard(stats: stats),
        ),
        loading: () => const LoadingIndicator(),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Failed to load dashboard',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void _showNotifications(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notifications'),
        content: const SizedBox(
          height: 200,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.info, color: Colors.blue),
                title: Text('System updated successfully'),
                subtitle: Text('5 minutes ago'),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.warning, color: Colors.orange),
                title: Text('Low storage warning'),
                subtitle: Text('2 hours ago'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class _MobileAdminDashboard extends StatelessWidget {
  final AdminStats stats;
  
  const _MobileAdminDashboard({required this.stats});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildStatsGrid(context, stats),
          const SizedBox(height: 24),
          _buildQuickActions(context),
          const SizedBox(height: 24),
          _buildRecentActivity(context, stats),
        ],
      ),
    );
  }
}

class _DesktopAdminDashboard extends StatelessWidget {
  final AdminStats stats;
  
  const _DesktopAdminDashboard({required this.stats});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left column - Stats & Analytics
          Expanded(
            flex: 3,
            child: Column(
              children: [
                _buildStatsGrid(context, stats),
                const SizedBox(height: 24),
                _buildAnalyticsChart(context),
                const SizedBox(height: 24),
                _buildUserManagement(context),
              ],
            ),
          ),
          
          const SizedBox(width: 24),
          
          // Right column - Quick Actions & Activity
          Expanded(
            flex: 2,
            child: Column(
              children: [
                _buildQuickActions(context),
                const SizedBox(height: 24),
                _buildRecentActivity(context, stats),
                const SizedBox(height: 24),
                _buildSystemHealth(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildStatsGrid(BuildContext context, AdminStats stats) {
  final theme = Theme.of(context);
  
  return GridView.count(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
    crossAxisSpacing: 16,
    mainAxisSpacing: 16,
    childAspectRatio: 1.2,
    children: [
      _StatCard(
        title: 'Total Users',
        value: stats.totalUsers.toString(),
        icon: Icons.people,
        color: AppColors.adminColor,
      ),
      _StatCard(
        title: 'Dentists',
        value: stats.totalDentists.toString(),
        icon: Icons.medical_services,
        color: AppColors.dentistColor,
      ),
      _StatCard(
        title: 'Patients',
        value: stats.totalPatients.toString(),
        icon: Icons.person,
        color: AppColors.patientColor,
      ),
      _StatCard(
        title: 'Appointments',
        value: stats.totalAppointments.toString(),
        icon: Icons.calendar_today,
        color: Colors.amber,
      ),
      _StatCard(
        title: 'Pending',
        value: stats.pendingAppointments.toString(),
        icon: Icons.pending_actions,
        color: Colors.orange,
      ),
      _StatCard(
        title: 'Monthly Revenue',
        value: '\$${stats.monthlyRevenue.toStringAsFixed(2)}',
        icon: Icons.attach_money,
        color: Colors.green,
      ),
    ],
  );
}

Widget _buildQuickActions(BuildContext context) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              ActionChip(
                avatar: const Icon(Icons.person_add, size: 18),
                label: const Text('Add User'),
                onPressed: () => _showAddUserDialog(context),
              ),
              ActionChip(
                avatar: const Icon(Icons.notifications_active, size: 18),
                label: const Text('Send Alert'),
                onPressed: () => _showSendAlertDialog(context),
              ),
              ActionChip(
                avatar: const Icon(Icons.settings, size: 18),
                label: const Text('Settings'),
                onPressed: () => _navigateToSettings(context),
              ),
              ActionChip(
                avatar: const Icon(Icons.report, size: 18),
                label: const Text('Generate Report'),
                onPressed: () => _generateReport(context),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildRecentActivity(BuildContext context, AdminStats stats) {
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
                'Recent Activity',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminAppointmentsScreen(),
                  ),
                ),
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...stats.recentAppointments.take(3).map((appointment) => ListTile(
            leading: CircleAvatar(
              backgroundColor: _getStatusColor(appointment.status),
              child: Icon(
                _getStatusIcon(appointment.status),
                size: 16,
                color: Colors.white,
              ),
            ),
            title: Text('Appointment with ${appointment.patientName}'),
            subtitle: Text(
              '${appointment.appointmentDate.toString()} - ${appointment.status}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _viewAppointmentDetails(context, appointment),
          )),
        ],
      ),
    ),
  );
}

Widget _buildAnalyticsChart(BuildContext context) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Revenue Analytics',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              series: <ColumnSeries<Map<String, dynamic>, String>>[
                ColumnSeries<Map<String, dynamic>, String>(
                  dataSource: [
                    {'month': 'Jan', 'revenue': 12000},
                    {'month': 'Feb', 'revenue': 15000},
                    {'month': 'Mar', 'revenue': 18000},
                    {'month': 'Apr', 'revenue': 14000},
                    {'month': 'May', 'revenue': 20000},
                    {'month': 'Jun', 'revenue': 22000},
                  ],
                  xValueMapper: (data, _) => data['month'],
                  yValueMapper: (data, _) => data['revenue'],
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.1),
              child: Icon(icon, color: color),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

Color _getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'confirmed':
      return Colors.green;
    case 'pending':
      return Colors.orange;
    case 'cancelled':
      return Colors.red;
    default:
      return Colors.grey;
  }
}

IconData _getStatusIcon(String status) {
  switch (status.toLowerCase()) {
    case 'confirmed':
      return Icons.check_circle;
    case 'pending':
      return Icons.pending;
    case 'cancelled':
      return Icons.cancel;
    default:
      return Icons.info;
  }
}

void _showAddUserDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Add New User'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Email'),
          ),
          SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(labelText: 'Full Name'),
          ),
          SizedBox(height: 12),
          DropdownButtonFormField(
            items: [
              DropdownMenuItem(value: 'patient', child: Text('Patient')),
              DropdownMenuItem(value: 'dentist', child: Text('Dentist')),
              DropdownMenuItem(value: 'admin', child: Text('Admin')),
            ],
            decoration: InputDecoration(labelText: 'Role'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // TODO: Implement add user
            Navigator.pop(context);
          },
          child: const Text('Add User'),
        ),
      ],
    ),
  );
}

void _showSendAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Send Alert'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
          ),
          SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(labelText: 'Message'),
            maxLines: 3,
          ),
          SizedBox(height: 12),
          DropdownButtonFormField(
            items: [
              DropdownMenuItem(value: 'all', child: Text('All Users')),
              DropdownMenuItem(value: 'dentists', child: Text('Dentists Only')),
              DropdownMenuItem(value: 'patients', child: Text('Patients Only')),
            ],
            decoration: InputDecoration(labelText: 'Send To'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // TODO: Implement send alert
            Navigator.pop(context);
          },
          child: const Text('Send'),
        ),
      ],
    ),
  );
}

void _navigateToSettings(BuildContext context) {
  // TODO: Implement settings navigation
}

void _generateReport(BuildContext context) {
  // TODO: Implement report generation
}

void _viewAppointmentDetails(BuildContext context, AppointmentEntity appointment) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Appointment Details'),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Patient: ${appointment.patientName}'),
            Text('Dentist: ${appointment.dentistName}'),
            Text('Date: ${appointment.appointmentDate.toString()}'),
            Text('Time: ${appointment.appointmentTime}'),
            Text('Status: ${appointment.status}'),
            if (appointment.reason != null) Text('Reason: ${appointment.reason}'),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
        ElevatedButton(
          onPressed: () {
            // TODO: Implement edit appointment
            Navigator.pop(context);
          },
          child: const Text('Edit'),
        ),
      ],
    ),
  );
}