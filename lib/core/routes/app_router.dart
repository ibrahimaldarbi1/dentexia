import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/presentation/providers/auth_providers.dart';
import '../../features/auth/domain/entities/user_entity.dart';

class AppRouter {
  final Ref ref;

  AppRouter(this.ref);

  GoRouter get config => _router;

  late final GoRouter _router = GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final authState = ref.read(authNotifierProvider);
      
      return authState.when(
        initial: () => null,
        loading: () => '/splash',
        authenticated: (user) {
          // If trying to access auth pages while logged in, redirect to dashboard
          if (state.location.startsWith('/login') ||
              state.location.startsWith('/signup') ||
              state.location == '/splash') {
            return _getDashboardRoute(user);
          }
          return null;
        },
        unauthenticated: (error) {
          // If trying to access protected routes while not logged in
          if (!state.location.startsWith('/login') &&
              !state.location.startsWith('/signup') &&
              state.location != '/splash') {
            return '/login';
          }
          return null;
        },
        error: (error) => '/login',
      );
    },
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        pageBuilder: (context, state) => const MaterialPage(
          child: SplashScreen(),
        ),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        pageBuilder: (context, state) => const MaterialPage(
          child: LoginScreen(),
        ),
      ),
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        pageBuilder: (context, state) {
          final authState = ref.read(authNotifierProvider);
          return authState.when(
            authenticated: (user) => MaterialPage(
              child: _getDashboardWidget(user),
            ),
            orElse: () => const MaterialPage(
              child: Scaffold(body: Center(child: CircularProgressIndicator())),
            ),
          );
        },
      ),
      // Role-specific routes
      ShellRoute(
        builder: (context, state, child) {
          return RoleBasedLayout(child: child);
        },
        routes: [
          GoRoute(
            path: '/admin',
            name: 'admin',
            pageBuilder: (context, state) => const MaterialPage(
              child: AdminDashboard(),
            ),
            routes: [
              GoRoute(
                path: 'users',
                name: 'admin_users',
                pageBuilder: (context, state) => const MaterialPage(
                  child: AdminUsersScreen(),
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/dentist',
            name: 'dentist',
            pageBuilder: (context, state) => const MaterialPage(
              child: DentistDashboard(),
            ),
          ),
          GoRoute(
            path: '/patient',
            name: 'patient',
            pageBuilder: (context, state) => const MaterialPage(
              child: PatientDashboard(),
            ),
          ),
        ],
      ),
    ],
  );

  String _getDashboardRoute(UserEntity user) {
    switch (user.role) {
      case UserRole.admin:
        return '/admin';
      case UserRole.dentist:
        return '/dentist';
      case UserRole.patient:
        return '/patient';
      default:
        return '/login';
    }
  }

  Widget _getDashboardWidget(UserEntity user) {
    switch (user.role) {
      case UserRole.admin:
        return const AdminDashboard();
      case UserRole.dentist:
        return const DentistDashboard();
      case UserRole.patient:
        return const PatientDashboard();
      default:
        return const LoginScreen();
    }
  }
}