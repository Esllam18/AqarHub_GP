import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class LocationCard extends StatelessWidget {
  final String address;
  final VoidCallback onTap;

  const LocationCard({super.key, required this.address, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(ResponsiveHelper.width(12)), // ✅ Reduced
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(14)),
          border: Border.all(
            color: AppColors.primary.withOpacity(0.15),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            // Location Icon
            Container(
              width: ResponsiveHelper.width(45), // ✅ Reduced
              height: ResponsiveHelper.width(45),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(
                  ResponsiveHelper.radius(10),
                ),
              ),
              child: Icon(
                Icons.location_on_rounded,
                color: AppColors.primary,
                size: ResponsiveHelper.width(24),
              ),
            ),

            SizedBox(width: ResponsiveHelper.width(12)),

            // Address
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الموقع',
                    style: GoogleFonts.tajawal(
                      fontSize: ResponsiveHelper.fontSize(11),
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(height: ResponsiveHelper.height(2)),
                  Text(
                    address,
                    style: GoogleFonts.cairo(
                      fontSize: ResponsiveHelper.fontSize(13), // ✅ Reduced
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                    textDirection: TextDirection.rtl,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            SizedBox(width: ResponsiveHelper.width(8)),

            // Arrow Icon
            Container(
              padding: EdgeInsets.all(ResponsiveHelper.width(6)),
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: AppColors.white,
                size: ResponsiveHelper.width(12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
