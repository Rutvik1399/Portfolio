import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// Helper widget and utilities to build responsive UI across Mobile, Tablet, and Desktop.
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(
    BuildContext context,
    bool isMobile,
    bool isTablet,
    bool isDesktop,
  ) builder;

  const ResponsiveBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = MediaQuery.sizeOf(context).width;
        final isMobile = width < AppConstants.mobileBreakpoint;
        final isTablet = width >= AppConstants.mobileBreakpoint &&
            width <= AppConstants.tabletBreakpoint;
        final isDesktop = width > AppConstants.tabletBreakpoint;

        return builder(context, isMobile, isTablet, isDesktop);
      },
    );
  }
}

class Responsive {
  Responsive._();

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < AppConstants.mobileBreakpoint;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= AppConstants.mobileBreakpoint &&
        width <= AppConstants.tabletBreakpoint;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width > AppConstants.tabletBreakpoint;

  /// Returns value based on current breakpoint.
  static T value<T>({
    required BuildContext context,
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet ?? desktop;
    return desktop;
  }
}
