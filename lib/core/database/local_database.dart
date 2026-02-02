// lib/core/database/local_database.dart
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocalDatabase {
  static const String appointmentsBox = 'appointments';
  static const String patientsBox = 'patients';
  static const String dentistsBox = 'dentists';
  static const String notificationsBox = 'notifications';
  static const String pendingOperationsBox = 'pending_operations';
  
  static bool _isInitialized = false;
  
  static Future<void> init() async {
    if (_isInitialized) return;
    
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    
    // Note: You need to register adapters first
    // Hive.registerAdapter(AppointmentAdapter());
    // Hive.registerAdapter(PatientAdapter());
    
    // Open boxes
    await Hive.openBox(appointmentsBox);
    await Hive.openBox(patientsBox);
    await Hive.openBox(dentistsBox);
    await Hive.openBox(notificationsBox);
    await Hive.openBox(pendingOperationsBox);
    
    _isInitialized = true;
  }
  
  static Future<void> saveAppointments(List<Map<String, dynamic>> appointments) async {
    await init();
    final box = Hive.box(appointmentsBox);
    await box.put('appointments', appointments);
    await box.put('last_sync', DateTime.now().toIso8601String());
  }
  
  static Future<List<Map<String, dynamic>>> getAppointments() async {
    await init();
    final box = Hive.box(appointmentsBox);
    final appointments = box.get('appointments', defaultValue: []);
    return List<Map<String, dynamic>>.from(appointments);
  }
  
  static Future<bool> isDataStale() async {
    await init();
    final box = Hive.box(appointmentsBox);
    final lastSync = box.get('last_sync');
    
    if (lastSync == null) return true;
    
    final lastSyncDate = DateTime.parse(lastSync);
    final now = DateTime.now();
    final difference = now.difference(lastSyncDate);
    
    return difference.inHours > 1;
  }
  
  static Future<void> queueOperation({
    required String type,
    required Map<String, dynamic> data,
  }) async {
    await init();
    final box = Hive.box(pendingOperationsBox);
    final operations = box.get('operations', defaultValue: []);
    operations.add({
      'type': type,
      'data': data,
      'timestamp': DateTime.now().toIso8601String(),
    });
    await box.put('operations', operations);
  }
  
  static Future<List<Map<String, dynamic>>> getPendingOperations() async {
    await init();
    final box = Hive.box(pendingOperationsBox);
    final operations = box.get('operations', defaultValue: []);
    return List<Map<String, dynamic>>.from(operations);
  }
  
  static Future<void> clearPendingOperations() async {
    await init();
    final box = Hive.box(pendingOperationsBox);
    await box.put('operations', []);
  }
  
  static Future<void> clearAll() async {
    await Hive.deleteFromDisk();
    _isInitialized = false;
  }
}