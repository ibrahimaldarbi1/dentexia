import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/failure/failure.dart';

abstract class NotificationRepository {
  FutureEither<List<Notification>> getNotifications({
    int limit = 20,
    int offset = 0,
    bool unreadOnly = false,
  });
  
  FutureEither<void> markAsRead(String notificationId);
  FutureEither<void> markAllAsRead();
  FutureEither<void> deleteNotification(String notificationId);
  
  Stream<List<Notification>> watchNotifications();
  
  FutureEither<int> getUnreadCount();
}

class Notification {
  final String id;
  final String title;
  final String message;
  final String type; // info, warning, success, error
  final Map<String, dynamic>? data;
  final bool isRead;
  final DateTime createdAt;
  final String? senderId;
  final String? senderName;
  
  Notification({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    this.data,
    required this.isRead,
    required this.createdAt,
    this.senderId,
    this.senderName,
  });
}