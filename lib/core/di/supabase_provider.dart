// lib/core/di/supabase_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

final supabaseInitializationProvider = FutureProvider<void>((ref) async {
  await Supabase.initialize(
    url: 'https://bznobpvlqryvqujnhejr.supabase.co',
    anonKey: 'sb_publishable_ZBo2z9Enf88QlsrIQhTaIQ_GCbKr3d4',
    // authCallbackUrlHostname was renamed to redirectUrl in newer versions
    // If you need deep linking, use the following instead:
    // redirectUrl: 'myapp://login-callback', // For mobile deep linking
    debug: true, // Set to false in production
  );
  
  // Configure realtime - FIXED: Use auth.currentSession?.accessToken
  final session = ref.read(supabaseClientProvider).auth.currentSession;
  if (session != null) {
    ref.read(supabaseClientProvider).realtime.setAuth(session.accessToken);
  }
});