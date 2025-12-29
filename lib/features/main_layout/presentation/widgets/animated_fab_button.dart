import 'package:flutter/material.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class AnimatedFabButton extends StatelessWidget {
  final Animation<double> scaleAnimation;
  final VoidCallback onPressed;

  const AnimatedFabButton({
    super.key,
    required this.scaleAnimation,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: Container(
        width: ResponsiveHelper.width(60),
        height: ResponsiveHelper.width(60),
        decoration: _buildDecoration(),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
            child: Icon(
              Icons.add_rounded,
              color: AppColors.white,
              size: ResponsiveHelper.width(32),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [AppColors.primary, AppColors.secondary],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
      boxShadow: [
        BoxShadow(
          color: AppColors.primary.withOpacity(0.4),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}
