import 'package:flutter/material.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class SuccessIcon extends StatelessWidget {
  const SuccessIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ResponsiveHelper.width(120),
      height: ResponsiveHelper.width(120),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.success.withOpacity(0.1),
      ),
      child: Icon(
        Icons.check_circle_rounded,
        size: ResponsiveHelper.width(80),
        color: AppColors.success,
      ),
    );
  }
}
