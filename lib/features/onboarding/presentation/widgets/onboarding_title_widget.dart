import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingTitleWidget extends StatelessWidget {
  final String title;

  const OnboardingTitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final fontSize = ResponsiveHelper.responsive<double>(
      context: context,
      mobile: 28.0,
      tablet: 36.0,
      desktop: 44.0,
    );

    return Text(
      title,
      textAlign: TextAlign.center,
      style: GoogleFonts.cairo(
        fontSize: ResponsiveHelper.fontSize(fontSize),
        fontWeight: FontWeight.w800,
        color: AppColors.primary,
        height: 1.4,
      ),
    );
  }
}
