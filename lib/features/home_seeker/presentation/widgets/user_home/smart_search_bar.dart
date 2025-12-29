import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/consts/home_strings.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class SmartSearchBar extends StatelessWidget {
  final VoidCallback onTap;

  const SmartSearchBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.width(14),
          vertical: ResponsiveHelper.height(12),
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(14)),
          border: Border.all(
            color: AppColors.primary.withOpacity(0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: ResponsiveHelper.height(8),
              offset: Offset(0, ResponsiveHelper.height(2)),
            ),
          ],
        ),
        child: Row(
          textDirection: TextDirection.rtl, // RTL: Icon on right, arrow on left
          children: [
            // AI Icon (will appear on RIGHT in RTL)
            Container(
              padding: EdgeInsets.all(ResponsiveHelper.width(8)),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                ),
                borderRadius: BorderRadius.circular(
                  ResponsiveHelper.radius(10),
                ),
              ),
              child: Icon(
                Icons.psychology_outlined,
                color: AppColors.white,
                size: ResponsiveHelper.width(20),
              ),
            ),
            SizedBox(width: ResponsiveHelper.width(12)),
            // Search Text (Middle)
            Expanded(
              child: Text(
                HomeStrings.searchWithAI,
                style: GoogleFonts.tajawal(
                  fontSize: ResponsiveHelper.fontSize(14),
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                ),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
              ),
            ),
            // Arrow (will appear on LEFT in RTL)
            Icon(
              Icons.arrow_back_ios_rounded, // Changed to back arrow for RTL
              color: Colors.grey.shade400,
              size: ResponsiveHelper.width(14),
            ),
          ],
        ),
      ),
    );
  }
}
