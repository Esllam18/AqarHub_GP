import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback onTap;
  final Color? iconColor;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.width(16),
          vertical: ResponsiveHelper.height(14),
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            // Icon Container
            Container(
              width: ResponsiveHelper.width(44),
              height: ResponsiveHelper.width(44),
              decoration: BoxDecoration(
                color: (iconColor ?? AppColors.primary).withOpacity(0.1),
                borderRadius: BorderRadius.circular(
                  ResponsiveHelper.radius(12),
                ),
              ),
              child: Icon(
                icon,
                color: iconColor ?? AppColors.primary,
                size: ResponsiveHelper.width(22),
              ),
            ),

            SizedBox(width: ResponsiveHelper.width(14)),

            // Title and Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.cairo(
                      fontSize: ResponsiveHelper.fontSize(15),
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: ResponsiveHelper.height(3)),
                    Text(
                      subtitle!,
                      style: GoogleFonts.tajawal(
                        fontSize: ResponsiveHelper.fontSize(12),
                        color: Colors.grey.shade600,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ],
              ),
            ),

            // Trailing
            trailing ??
                Icon(
                  Icons.chevron_left_rounded,
                  color: Colors.grey.shade400,
                  size: ResponsiveHelper.width(20),
                ),
          ],
        ),
      ),
    );
  }
}
