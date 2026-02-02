import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../platform/platform_utils.dart';
import '../../features/auth/presentation/providers/auth_providers.dart';

class RoleBasedLayout extends ConsumerWidget {
  final Widget child;
  
  const RoleBasedLayout({super.key, required this.child});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final platform = PlatformUtils.getPlatform(context);
    
    return authState.when(
      authenticated: (user) {
        return Scaffold(
          body: SafeArea(
            child: Row(
              children: [
                // Sidebar for desktop/tablet
                if (platform != AppPlatform.mobile)
                  _buildSidebar(user, context, ref),
                
                Expanded(
                  child: Column(
                    children: [
                      // Top app bar for all platforms
                      _buildAppBar(user, context, ref),
                      
                      Expanded(
                        child: child,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Bottom navigation for mobile
          bottomNavigationBar: platform == AppPlatform.mobile 
              ? _buildBottomNav(user, context, ref)
              : null,
        );
      },
      orElse: () => child,
    );
  }
  
  Widget _buildSidebar(UserEntity user, BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(right: BorderSide(color: theme.dividerColor)),
      ),
      child: Column(
        children: [
          // User info
          _buildUserInfo(user, context),
          
          // Navigation items based on role
          ..._getRoleNavigationItems(user, context, ref),
        ],
      ),
    );
  }
  
  List<Widget> _getRoleNavigationItems(UserEntity user, BuildContext context, WidgetRef ref) {
    switch (user.role) {
      case UserRole.admin:
        return _getAdminNavItems(context, ref);
      case UserRole.dentist:
        return _getDentistNavItems(context, ref);
      case UserRole.patient:
        return _getPatientNavItems(context, ref);
      default:
        return [];
    }
  }
}