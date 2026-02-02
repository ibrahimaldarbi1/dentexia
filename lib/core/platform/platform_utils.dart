import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform;
import 'package:flutter/material.dart';

enum AppPlatform { mobile, tablet, desktop }

class PlatformUtils {
  static AppPlatform getPlatform(BuildContext context) {
    if (kIsWeb) {
      // You said no web, but keeping for completeness
      final size = MediaQuery.of(context).size;
      return size.width < 600 ? AppPlatform.mobile : 
             size.width < 1200 ? AppPlatform.tablet : AppPlatform.desktop;
    }
    
    // For native platforms
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
        // Check if it's a tablet
        final size = MediaQuery.of(context).size;
        final shortestSide = size.shortestSide;
        return shortestSide > 600 ? AppPlatform.tablet : AppPlatform.mobile;
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
        return AppPlatform.desktop;
      default:
        return AppPlatform.mobile;
    }
  }
  
  static bool isMobile(BuildContext context) => 
      getPlatform(context) == AppPlatform.mobile;
      
  static bool isTablet(BuildContext context) => 
      getPlatform(context) == AppPlatform.tablet;
      
  static bool isDesktop(BuildContext context) => 
      getPlatform(context) == AppPlatform.desktop;
      
  static String getPlatformName() {
    if (kIsWeb) return 'web';
    return Platform.operatingSystem;
  }
}