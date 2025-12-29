import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/consts/home_strings.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class HomeWelcomeSection extends StatelessWidget {
  final String greeting;

  const HomeWelcomeSection({super.key, required this.greeting});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          greeting,
          style: GoogleFonts.tajawal(
            fontSize: ResponsiveHelper.fontSize(13),
            color: AppColors.white.withOpacity(0.85),
            fontWeight: FontWeight.w500,
            letterSpacing: 0.3,
          ),
          textDirection: TextDirection.rtl,
        ),
        SizedBox(height: ResponsiveHelper.height(4)),
        Text(
          HomeStrings.welcomeMessage,
          style: GoogleFonts.cairo(
            fontSize: ResponsiveHelper.fontSize(18),
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
          textDirection: TextDirection.rtl,
        ),
        SizedBox(height: ResponsiveHelper.height(4)),
        Text(
          HomeStrings.chooseProperty,
          style: GoogleFonts.tajawal(
            fontSize: ResponsiveHelper.fontSize(12),
            color: AppColors.white.withOpacity(0.8),
            fontWeight: FontWeight.w400,
          ),
          textDirection: TextDirection.rtl,
        ),
      ],
    );
  }
}
