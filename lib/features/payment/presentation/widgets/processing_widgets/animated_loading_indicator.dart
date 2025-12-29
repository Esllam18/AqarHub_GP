import 'package:flutter/material.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class AnimatedLoadingIndicator extends StatelessWidget {
  final AnimationController controller;

  const AnimatedLoadingIndicator({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: controller,
      child: Container(
        width: ResponsiveHelper.width(100),
        height: ResponsiveHelper.width(100),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
          ),
        ),
        child: Center(
          child: Container(
            width: ResponsiveHelper.width(80),
            height: ResponsiveHelper.width(80),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white,
            ),
            child: Icon(
              Icons.credit_card_rounded,
              size: ResponsiveHelper.width(40),
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}
