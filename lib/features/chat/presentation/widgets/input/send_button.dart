import 'package:flutter/material.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class SendButton extends StatelessWidget {
  final Animation<double> scaleAnimation;
  final VoidCallback onSend;

  const SendButton({
    super.key,
    required this.scaleAnimation,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: GestureDetector(
        onTap: onSend,
        child: Container(
          key: const ValueKey('send'),
          width: ResponsiveHelper.width(48),
          height: ResponsiveHelper.width(48),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.secondary],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            Icons.send_rounded,
            color: AppColors.white,
            size: ResponsiveHelper.width(22),
          ),
        ),
      ),
    );
  }
}
