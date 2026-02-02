import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'realtime_providers.g.dart';

@riverpod
Stream<List<Map<String, dynamic>>> realtimeAppointments(
  RealtimeAppointmentsRef ref, {
  required String userId,
}) {
  final supabase = ref.watch(supabaseClientProvider);
  
  return supabase
      .from('appointments')
      .stream(primaryKey: ['id'])
      .eq('patient_id', userId)
      .or('dentist_id.eq.$userId')
      .order('appointment_date', ascending: false)
      .map((data) => data);
}

@riverpod
Stream<List<Map<String, dynamic>>> realtimeNotifications(
  RealtimeNotificationsRef ref,
) {
  final supabase = ref.watch(supabaseClientProvider);
  final userId = supabase.auth.currentUser?.id;
  
  if (userId == null) {
    return const Stream.empty();
  }
  
  return supabase
      .from('notifications')
      .stream(primaryKey: ['id'])
      .eq('user_id', userId)
      .order('created_at', ascending: false)
      .limit(20)
      .map((data) => data);
}

@riverpod
Stream<int> unreadNotificationCount(UnreadNotificationCountRef ref) {
  final supabase = ref.watch(supabaseClientProvider);
  final userId = supabase.auth.currentUser?.id;
  
  if (userId == null) {
    return Stream.value(0);
  }
  
  return supabase
      .from('notifications')
      .stream(primaryKey: ['id'])
      .eq('user_id', userId)
      .eq('is_read', false)
      .map((data) => data.length);
}