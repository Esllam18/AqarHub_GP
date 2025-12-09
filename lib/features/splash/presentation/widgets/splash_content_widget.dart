import 'package:flutter/material.dart';
import '../../../../core/widgets/animated_logo_widget.dart';
import '../../../../core/widgets/animated_text_widget.dart';

class SplashContentWidget extends StatelessWidget {
  final Animation<double> logoScaleAnimation;
  final Animation<double> logoRotateAnimation;
  final Animation<double> logoFadeAnimation;
  final Animation<double> textSlideAnimation;
  final Animation<double> textFadeAnimation;

  const SplashContentWidget({
    super.key,
    required this.logoScaleAnimation,
    required this.logoRotateAnimation,
    required this.logoFadeAnimation,
    required this.textSlideAnimation,
    required this.textFadeAnimation,
  });

  @override
  Widget build(BuildContext context) {
    // Responsive spacing
    // final spacingBetweenLogoAndText = ResponsiveHelper.responsive<double>(
    //   context: context,
    //   mobile: 40.0,
    //   tablet: 60.0,
    //   desktop: 80.0,
    // );

    // final spacingBetweenTexts = ResponsiveHelper.responsive<double>(
    //   context: context,
    //   mobile: 16.0,
    //   tablet: 24.0,
    //   desktop: 32.0,
    // );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Logo
        AnimatedLogoWidget(
          scaleAnimation: logoScaleAnimation,
          rotateAnimation: logoRotateAnimation,
          fadeAnimation: logoFadeAnimation,
        ),

        // Arabic Text
        AnimatedTextWidget(
          slideAnimation: textSlideAnimation,
          fadeAnimation: textFadeAnimation,
          isArabic: true,
        ),

        // English Text
        AnimatedTextWidget(
          slideAnimation: textSlideAnimation,
          fadeAnimation: textFadeAnimation,
          isArabic: false,
        ),
      ],
    );
  }
}
