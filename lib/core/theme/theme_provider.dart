import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_theme.dart';

final themeProvider =
    NotifierProvider<ThemeNotifier, ThemeData>(ThemeNotifier.new);

class ThemeNotifier extends Notifier<ThemeData> {
  @override
  ThemeData build() {
    _loadTheme();
    return AppTheme.lightTheme;
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDarkMode') ?? false;
    state = isDark ? AppTheme.darkTheme : AppTheme.lightTheme;
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = state.brightness == Brightness.dark;

    state = isDark ? AppTheme.lightTheme : AppTheme.darkTheme;
    await prefs.setBool('isDarkMode', !isDark);
  }

  bool get isDarkMode => state.brightness == Brightness.dark;
}
