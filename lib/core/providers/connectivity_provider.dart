// lib/core/providers/connectivity_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:hive/hive.dart';
part 'connectivity_provider.g.dart';

@riverpod
Stream<ConnectivityStatus> connectivityStatus(Ref ref) async* {
  final connectivity = Connectivity();

  final initialResults = await connectivity.checkConnectivity();
  yield _mapConnectivityResults(initialResults);

  await for (final results in connectivity.onConnectivityChanged) {
    yield _mapConnectivityResults(results);
  }
}


@riverpod
class OfflineDataNotifier extends _$OfflineDataNotifier {
  @override
  Map<String, dynamic> build() {
    return {};
  }
  
  Future<void> saveOfflineAppointment(Map<String, dynamic> appointment) async {
    final pending = state['pending_appointments'] ?? [];
    pending.add({
      ...appointment,
      'id': 'offline_${DateTime.now().millisecondsSinceEpoch}',
      'is_offline': true,
    });
    
    state = {
      ...state,
      'pending_appointments': pending,
    };
    
    // Save to local database - FIXED: Call the correct method
    await _savePendingOperation('create_appointment', appointment);
  }
  
  Future<void> _savePendingOperation(String type, Map<String, dynamic> data) async {
    // This is a temporary implementation until LocalDatabase is complete
    final box = await Hive.openBox('pending_operations');
    final operations = box.get('operations', defaultValue: []);
    operations.add({
      'type': type,
      'data': data,
      'timestamp': DateTime.now().toIso8601String(),
    });
    await box.put('operations', operations);
  }
}

enum ConnectivityStatus {
  connected,
  disconnected,
  unknown,
}

ConnectivityStatus _mapConnectivityResults(List<ConnectivityResult> results) {
  if (results.isEmpty) {
    return ConnectivityStatus.disconnected;
  }

  // If ANY usable connection exists → connected
  if (results.any((result) =>
      result == ConnectivityResult.wifi ||
      result == ConnectivityResult.mobile ||
      result == ConnectivityResult.ethernet ||
      result == ConnectivityResult.vpn ||
      result == ConnectivityResult.other)) {
    return ConnectivityStatus.connected;
  }

  return ConnectivityStatus.disconnected;
}