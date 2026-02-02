import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseClient {
  static final supabase = Supabase.instance.client;
  
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://bznobpvlqryvqujnhejr.supabase.co',
      anonKey: 'sb_publishable_ZBo2z9Enf88QlsrIQhTaIQ_GCbKr3d4',
    );
  }
}