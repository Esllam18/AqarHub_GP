import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const StatItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.white, size: ResponsiveHelper.width(16)),
        SizedBox(width: ResponsiveHelper.width(6)),
        Text(
          value,
          style: GoogleFonts.cairo(
            fontSize: ResponsiveHelper.fontSize(16),
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        SizedBox(width: ResponsiveHelper.width(4)),
        Text(
          label,
          style: GoogleFonts.tajawal(
            fontSize: ResponsiveHelper.fontSize(11),
            color: AppColors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }
}
