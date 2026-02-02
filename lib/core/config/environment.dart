// lib/core/config/environment.dart
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // ADD THIS IMPORT

enum Environment {
  development,
  staging,
  production,
}

class AppConfig {
  final Environment environment;
  final String supabaseUrl;
  final String supabaseAnonKey;
  final bool enableLogging;
  final bool enableAnalytics;

  const AppConfig({
    required this.environment,
    required this.supabaseUrl,
    required this.supabaseAnonKey,
    required this.enableLogging,
    required this.enableAnalytics,
  });

  factory AppConfig.development() {
    return const AppConfig(
      environment: Environment.development,
      supabaseUrl: 'https://development-project.supabase.co',
      supabaseAnonKey: 'development-anon-key',
      enableLogging: true,
      enableAnalytics: false,
    );
  }

  factory AppConfig.production() {
    return const AppConfig(
      environment: Environment.production,
      supabaseUrl: 'https://production-project.supabase.co',
      supabaseAnonKey: 'production-anon-key',
      enableLogging: false,
      enableAnalytics: true,
    );
  }

  bool get isDevelopment => environment == Environment.development;
  bool get isProduction => environment == Environment.production;
}

// Provider for environment config - FIXED SYNTAX
final environmentConfigProvider = Provider<AppConfig>((ref) {
  if (kDebugMode) {
    return AppConfig.development();
  }
  return AppConfig.production();
});