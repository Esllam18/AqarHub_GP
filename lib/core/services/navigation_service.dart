import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationService {
  /// Navigate to route using GoRouter
  static void navigateTo(BuildContext context, String routeName, {Object? extra}) {
    context.push(routeName, extra: extra);
  }

  /// Navigate to route and replace using GoRouter
  static void navigateToAndReplace(BuildContext context, String routeName) {
    context.pushReplacement(routeName);
  }

  /// Navigate and clear stack (using go)
  static void navigateAndClear(BuildContext context, String routeName) {
    context.go(routeName);
  }

  /// Navigate back
  static void goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    }
  }

  /// Navigate with fade transition
  static void navigateWithFade(
    BuildContext context,
    Widget destination, {
    Duration duration = const Duration(milliseconds: 300),
  }) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => destination,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: duration,
      ),
    );
  }

  /// Navigate with slide transition
  static void navigateWithSlide(
    BuildContext context,
    Widget destination, {
    Duration duration = const Duration(milliseconds: 300),
    Offset begin = const Offset(1.0, 0.0),
  }) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => destination,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: begin,
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        transitionDuration: duration,
      ),
    );
  }
}
