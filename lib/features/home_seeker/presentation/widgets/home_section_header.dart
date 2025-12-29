import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/consts/home_strings.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class HomeSectionHeader extends StatelessWidget {
  final VoidCallback onSeeAllPressed;

  const HomeSectionHeader({super.key, required this.onSeeAllPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        ResponsiveHelper.width(16),
        ResponsiveHelper.height(4),
        ResponsiveHelper.width(16),
        ResponsiveHelper.height(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        textDirection: TextDirection.rtl,
        children: [
          Text(
            HomeStrings.featured,
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(15),
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textDirection: TextDirection.rtl,
          ),
          TextButton(
            onPressed: onSeeAllPressed,
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.width(8),
              ),
            ),
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                Text(
                  HomeStrings.seeAll,
                  style: GoogleFonts.tajawal(
                    fontSize: ResponsiveHelper.fontSize(12),
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(width: ResponsiveHelper.width(4)),
                Icon(
                  Icons.arrow_back_ios_rounded,
                  size: ResponsiveHelper.width(12),
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
