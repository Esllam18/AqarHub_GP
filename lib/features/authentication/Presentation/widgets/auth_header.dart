import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: GoogleFonts.cairo(
            fontSize: ResponsiveHelper.fontSize(28),
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: ResponsiveHelper.height(8)),
        Text(
          subtitle,
          style: GoogleFonts.tajawal(
            fontSize: ResponsiveHelper.fontSize(16),
            color: AppColors.primary.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}
