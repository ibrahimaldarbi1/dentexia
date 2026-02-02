import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    // Request permission
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    
    // Initialize local notifications
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );
    
    // Configure foreground message handling
    FirebaseMessaging.onMessage.listen(_showForegroundNotification);
    
    // Get token
    final token = await _firebaseMessaging.getToken();
    if (token != null) {
      _saveTokenToBackend(token);
    }
    
    // Handle token refresh
    FirebaseMessaging.onTokenRefresh.listen(_saveTokenToBackend);
  }
  
  void _showForegroundNotification(RemoteMessage message) {
    final notification = message.notification;
    if (notification != null) {
      _flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'dental_clinic_channel',
            'Dental Clinic Notifications',
            channelDescription: 'Appointment reminders and updates',
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: const DarwinNotificationDetails(),
        ),
      );
    }
  }
  
  void _onNotificationTap(NotificationResponse response) {
    // Handle notification tap
    // Navigate to appropriate screen
  }
  
  Future<void> _saveTokenToBackend(String token) async {
    // Save to Supabase
    // await supabase.from('user_tokens').upsert({
    //   'user_id': currentUserId,
    //   'token': token,
    //   'platform': Platform.operatingSystem,
    // });
  }
  
  Future<void> scheduleAppointmentReminder({
    required String appointmentId,
    required DateTime appointmentDate,
    required String patientName,
    required String dentistName,
  }) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      appointmentId.hashCode,
      'Appointment Reminder',
      'You have an appointment with $dentistName in 1 hour',
      appointmentDate.subtract(const Duration(hours: 1)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'appointment_reminders',
          'Appointment Reminders',
          channelDescription: 'Reminders for upcoming appointments',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}