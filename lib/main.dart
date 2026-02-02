import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'config/routes/app_router.dart';
import 'config/theme/app_theme.dart';
import 'core/local/hive_registrar.dart'; // import your HiveRegistrar

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Initialize Supabase
  await Supabase.initialize(
    url: 'https://htwfnacdmuxhybtchqbi.supabase.co',
    anonKey: 'sb_publishable_PcBivcMeFm8k4fMAW44Lnw_TWyhhmE0',
  );

  // 2. Initialize Hive (Local DB)
  await Hive.initFlutter();

  // 3. Register Hive Adapters
  await HiveRegistrar.init(); // <- Call this before runApp

  runApp(const ProviderScope(child: DentalApp()));
}

class DentalApp extends ConsumerWidget {
  const DentalApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Dental Clinic Pro',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
