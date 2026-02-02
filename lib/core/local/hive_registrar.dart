import 'package:hive_flutter/hive_flutter.dart';

class HiveRegistrar {
  static Future<void> init() async {
    await Hive.initFlutter();
    
    // Open boxes (tables)
    await Hive.openBox('settings');
    await Hive.openBox('sync_queue');
    await Hive.openBox('medical_records_cache');
  }
}