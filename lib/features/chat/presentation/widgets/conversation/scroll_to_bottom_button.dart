import 'package:flutter/material.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class ScrollToBottomButton extends StatelessWidget {
  final VoidCallback onTap;

  const ScrollToBottomButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: ResponsiveHelper.height(100),
      left: ResponsiveHelper.width(16),
      child: AnimatedOpacity(
        opacity: 1.0,
        duration: const Duration(milliseconds: 200),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: ResponsiveHelper.width(48),
            height: ResponsiveHelper.width(48),
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.primary,
              size: ResponsiveHelper.width(28),
            ),
          ),
        ),
      ),
    );
  }
}
