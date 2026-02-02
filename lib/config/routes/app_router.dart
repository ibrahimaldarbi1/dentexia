import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/providers/supabase_provider.dart';
import '../../features/auth/presentation/auth_controller.dart';
// Import screens (create placeholders for now)
import '../../features/auth/presentation/login_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/auth/domain/user_entity.dart';
import '../../features/admin/presentation/controllers/admin_layout.dart';
import '../../features/admin/presentation/screens/User_Management_Screen.dart';
import '../../features/dashboard/presentation/dentist_dashboard_screen.dart'; // From Phase 4
import '../../features/dashboard/presentation/patient_dashboard_screen.dart'; // From Phase 
import '../../features/patients/presentation/booking_screen.dart'; // From Phase 5
part 'app_router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  // Watch the Auth Controller to detect login/logout changes
  final authState = ref.watch(authControllerProvider);

  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final isLoading = authState.isLoading;
      final hasError = authState.hasError;
      final isAuthenticated = authState.valueOrNull != null; // Check if UserEntity exists
      
      final isLoginRoute = state.uri.toString() == '/login';

      // 1. If loading, don't redirect yet (or show splash)
      if (isLoading) return null;

      // 2. If not authenticated, force to login
      if (!isAuthenticated) return '/login';

      // 3. If authenticated and on login page, send to correct dashboard
      if (isAuthenticated && isLoginRoute) {
        final user = authState.valueOrNull!;
        
        switch (user.role) {
          case UserRole.admin:
            return '/admin-dashboard';
          case UserRole.dentist:
            return '/dentist-dashboard';
          case UserRole.patient:
          default:
            return '/patient-dashboard';
        }
      }

      return null; 
    },
    routes: [
ShellRoute(
  builder: (context, state, child) {
    // Only wrap with AdminLayout if the path starts with /admin-dashboard
    if (state.uri.toString().startsWith('/admin-dashboard')) {
      return AdminLayout(child: child);
    }
    return child;
  },
  routes: [
    GoRoute(
      path: '/admin-dashboard',
      redirect: (_, __) => '/admin-dashboard/users', // Default tab
    ),
    GoRoute(
      path: '/admin-dashboard/users',
      builder: (context, state) => const UserManagementScreen(),
    ),
    GoRoute(
      path: '/admin-dashboard/schedule',
      builder: (context, state) => const Scaffold(body: Center(child: Text("Clinic Schedule Settings"))),
    ),
  ],
),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/admin-dashboard',
        builder: (context, state) => const Scaffold(body: Center(child: Text('Admin Dashboard'))),
      ),
      GoRoute(
        path: '/dentist-dashboard',
        builder: (context, state) => const DentistDashboardScreen(), 
      ),
      GoRoute(
        path: '/patient-dashboard',
        builder: (context, state) => const PatientDashboardScreen(), 
        routes: [
           // Nested route for the Booking Wizard
           GoRoute(
             path: 'book', // accessible via /patient-dashboard/book
             builder: (context, state) => const BookingScreen(), 
           ),
        ],
      ),
    ],
  );
}