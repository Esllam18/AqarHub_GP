import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResponsiveHelper {
  /// Screen width
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  /// Screen height
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  /// Responsive width (percentage based)
  static double widthPercentage(BuildContext context, double percentage) =>
      screenWidth(context) * (percentage / 100);

  /// Responsive height (percentage based)
  static double heightPercentage(BuildContext context, double percentage) =>
      screenHeight(context) * (percentage / 100);

  /// Check if device is mobile (width < 600)
  static bool isMobile(BuildContext context) => screenWidth(context) < 600;

  /// Check if device is tablet (600 <= width < 1024)
  static bool isTablet(BuildContext context) {
    final width = screenWidth(context);
    return width >= 600 && width < 1024;
  }

  /// Check if device is desktop (width >= 1024)
  static bool isDesktop(BuildContext context) => screenWidth(context) >= 1024;

  /// Responsive font size using ScreenUtil
  static double fontSize(double size) => size.sp;

  /// Responsive width using ScreenUtil
  static double width(double width) => width.w;

  /// Responsive height using ScreenUtil
  static double height(double height) => height.h;

  /// Responsive radius using ScreenUtil
  static double radius(double radius) => radius.r;

  /// Responsive spacing (horizontal)
  static double horizontalSpacing(double spacing) => spacing.w;

  /// Responsive spacing (vertical)
  static double verticalSpacing(double spacing) => spacing.h;

  /// Get responsive value based on device type
  static T responsive<T>({
    required BuildContext context,
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop(context) && desktop != null) {
      return desktop;
    } else if (isTablet(context) && tablet != null) {
      return tablet;
    }
    return mobile;
  }

  /// Safe area padding
  static EdgeInsets safeAreaPadding(BuildContext context) =>
      MediaQuery.of(context).padding;

  /// Device pixel ratio
  static double pixelRatio(BuildContext context) =>
      MediaQuery.of(context).devicePixelRatio;
}
