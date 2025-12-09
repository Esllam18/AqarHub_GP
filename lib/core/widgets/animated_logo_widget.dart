import 'package:aqar_hub_gp/core/consts/app_assets.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class AnimatedLogoWidget extends StatelessWidget {
  final Animation<double> scaleAnimation;
  final Animation<double> rotateAnimation;
  final Animation<double> fadeAnimation;

  const AnimatedLogoWidget({
    super.key,
    required this.scaleAnimation,
    required this.rotateAnimation,
    required this.fadeAnimation,
  });

  @override
  Widget build(BuildContext context) {
    // Responsive logo size
    final logoSize = ResponsiveHelper.responsive<double>(
      context: context,
      mobile: 100.0,
      tablet: 200.0,
      desktop: 250.0,
    );

    return AnimatedBuilder(
      animation: Listenable.merge([
        scaleAnimation,
        rotateAnimation,
        fadeAnimation,
      ]),
      builder: (context, child) {
        return Transform.scale(
          scale: scaleAnimation.value,
          child: Transform.rotate(
            angle: rotateAnimation.value,
            child: Opacity(
              opacity: fadeAnimation.value,
              child: Image.asset(
                AppImages.logo,
                width: ResponsiveHelper.width(logoSize),
                height: ResponsiveHelper.height(logoSize),
              ),
            ),
          ),
        );
      },
    );
  }
}
