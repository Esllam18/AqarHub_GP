import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedTextWidget extends StatelessWidget {
  final Animation<double> slideAnimation;
  final Animation<double> fadeAnimation;
  final bool isArabic;

  const AnimatedTextWidget({
    super.key,
    required this.slideAnimation,
    required this.fadeAnimation,
    this.isArabic = true,
  });

  @override
  Widget build(BuildContext context) {
    final fontSize = ResponsiveHelper.responsive<double>(
      context: context,
      mobile: 24.0,
      tablet: 38.0,
      desktop: 48.0,
    );

    final text = isArabic ? 'عقار هاب' : 'AqarHub';

    final textStyle = isArabic
        ? GoogleFonts.arefRuqaa(
            fontSize: ResponsiveHelper.fontSize(fontSize + 5),
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          )
        : GoogleFonts.lora(
            fontSize: ResponsiveHelper.fontSize(fontSize),
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          );

    return AnimatedBuilder(
      animation: Listenable.merge([slideAnimation, fadeAnimation]),
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, slideAnimation.value),
          child: Opacity(
            opacity: fadeAnimation.value,
            child: Text(text, style: textStyle, textAlign: TextAlign.center),
          ),
        );
      },
    );
  }
}
