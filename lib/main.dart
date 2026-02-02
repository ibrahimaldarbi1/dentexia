import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/config/environment.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize environment
  const environment = AppConfig.development();
  
  // Initialize Riverpod logging for development
  if (environment.enableLogging) {
    // Enable Riverpod logging
  }
  
  runApp(
    ProviderScope(
      child: App(),
    ),
  );
}