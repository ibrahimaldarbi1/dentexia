import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/auth_controller.dart';

class AdminLayout extends ConsumerWidget {
  final Widget child; // The screen content (User List, Settings, etc.)

  const AdminLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Basic responsive check
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Console"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authControllerProvider.notifier).logout(),
          )
        ],
      ),
      drawer: !isDesktop ? _AdminSidebar(ref: ref) : null,
      body: Row(
        children: [
          if (isDesktop) SizedBox(width: 250, child: _AdminSidebar(ref: ref)),
          if (isDesktop) const VerticalDivider(width: 1),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _AdminSidebar extends StatelessWidget {
  final WidgetRef ref;
  const _AdminSidebar({required this.ref});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        ListTile(
          leading: const Icon(Icons.people),
          title: const Text('Staff & Users'),
          onTap: () => context.go('/admin-dashboard/users'),
        ),
        ListTile(
          leading: const Icon(Icons.calendar_today),
          title: const Text('Clinic Schedule'),
          onTap: () => context.go('/admin-dashboard/schedule'),
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () => context.go('/admin-dashboard/settings'),
        ),
      ],
    );
  }
}