import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingDescriptionWidget extends StatelessWidget {
  final String description;

  const OnboardingDescriptionWidget({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    final fontSize = ResponsiveHelper.responsive<double>(
      context: context,
      mobile: 16.0,
      tablet: 20.0,
      desktop: 24.0,
    );

    return Text(
      description,
      textAlign: TextAlign.center,
      style: GoogleFonts.tajawal(
        fontSize: ResponsiveHelper.fontSize(fontSize),
        fontWeight: FontWeight.w400,
        // ignore: deprecated_member_use
        color: AppColors.primary.withOpacity(0.7),
        height: 1.6,
      ),
    );
  }
}
