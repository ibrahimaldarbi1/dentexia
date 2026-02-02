import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/responsive_layout.dart';
import '../providers/admin_providers.dart';

class AdminDashboard extends ConsumerWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(adminStatsProvider);
    
    return ResponsiveLayout(
      mobile: _MobileAdminDashboard(stats: stats),
      tablet: _TabletAdminDashboard(stats: stats),
      desktop: _DesktopAdminDashboard(stats: stats),
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
        children: [
          _buildStatsRow(context, stats),
          const SizedBox(height: 24),
          _buildQuickActions(context),
          const SizedBox(height: 24),
          _buildRecentActivity(context),
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
          // Left column - Stats
          Expanded(
            flex: 2,
            child: Column(
              children: [
                _buildStatsGrid(context, stats),
                const SizedBox(height: 24),
                _buildUserManagement(context),
              ],
            ),
          ),
          
          const SizedBox(width: 24),
          
          // Right column - Activity & Quick Actions
          Expanded(
            flex: 1,
            child: Column(
              children: [
                _buildQuickActions(context),
                const SizedBox(height: 24),
                _buildRecentActivity(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}