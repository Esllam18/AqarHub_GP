import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class OnboardingImageWidget extends StatelessWidget {
  final String image;

  const OnboardingImageWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    final imageSize = ResponsiveHelper.responsive<double>(
      context: context,
      mobile: 280.0,
      tablet: 350.0,
      desktop: 450.0,
    );

    return Image.asset(
      image,
      width: ResponsiveHelper.width(imageSize),
      height: ResponsiveHelper.height(imageSize),
      fit: BoxFit.contain,
    );
  }
}
