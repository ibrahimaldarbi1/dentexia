import 'package:flutter/material.dart';
import '../platform/platform_utils.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  final Widget? mobileLarge;
  final Widget? tabletLarge;

  const ResponsiveLayout({
    Key? key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
    this.mobileLarge,
    this.tabletLarge,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final platform = PlatformUtils.getPlatform(context);
    final size = MediaQuery.of(context).size;

    if (platform == AppPlatform.mobile) {
      if (mobileLarge != null && size.width > 375) {
        return mobileLarge!;
      }
      return mobile;
    } else if (platform == AppPlatform.tablet) {
      if (tabletLarge != null && size.width > 800) {
        return tabletLarge!;
      }
      return tablet;
    } else {
      return desktop;
    }
  }
}

// Responsive value helper
class ResponsiveValue<T> {
  final T mobile;
  final T tablet;
  final T desktop;

  const ResponsiveValue({
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  T getValue(BuildContext context) {
    final platform = PlatformUtils.getPlatform(context);
    switch (platform) {
      case AppPlatform.mobile:
        return mobile;
      case AppPlatform.tablet:
        return tablet;
      case AppPlatform.desktop:
        return desktop;
    }
  }
}