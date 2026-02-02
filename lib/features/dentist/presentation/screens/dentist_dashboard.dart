import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../../core/widgets/responsive_layout.dart';
import '../providers/dentist_providers.dart';

class DentistDashboard extends ConsumerWidget {
  const DentistDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointments = ref.watch(todaysAppointmentsProvider);
    final upcoming = ref.watch(upcomingAppointmentsProvider);
    
    return ResponsiveLayout(
      mobile: _MobileDentistDashboard(
        appointments: appointments,
        upcoming: upcoming,
      ),
      tablet: _TabletDentistDashboard(
        appointments: appointments,
        upcoming: upcoming,
      ),
      desktop: _DesktopDentistDashboard(