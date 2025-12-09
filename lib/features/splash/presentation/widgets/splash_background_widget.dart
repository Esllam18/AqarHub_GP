import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:flutter/material.dart';

class SplashBackgroundWidget extends StatelessWidget {
  final Animation<double> backgroundAnimation;

  const SplashBackgroundWidget({super.key, required this.backgroundAnimation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: backgroundAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.white,
                // ignore: deprecated_member_use
                AppColors.background.withOpacity(backgroundAnimation.value),
              ],
            ),
          ),
        );
      },
    );
  }
}
