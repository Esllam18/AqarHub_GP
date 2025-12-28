import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class MediaEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color? color;

  const MediaEmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? AppColors.primary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(ResponsiveHelper.width(24)),
        decoration: BoxDecoration(
          color: effectiveColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
          border: Border.all(
            color: effectiveColor.withOpacity(0.2),
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: ResponsiveHelper.width(48),
              color: effectiveColor.withOpacity(0.5),
            ),
            SizedBox(height: ResponsiveHelper.height(12)),
            Text(
              title,
              style: GoogleFonts.cairo(
                fontSize: ResponsiveHelper.fontSize(16),
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textDirection: TextDirection.rtl,
            ),
            SizedBox(height: ResponsiveHelper.height(4)),
            Text(
              subtitle,
              style: GoogleFonts.tajawal(
                fontSize: ResponsiveHelper.fontSize(12),
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ),
    );
  }
}
