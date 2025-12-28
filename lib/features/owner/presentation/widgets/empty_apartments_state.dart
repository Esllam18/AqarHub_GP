import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class EmptyApartmentsState extends StatelessWidget {
  const EmptyApartmentsState({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(ResponsiveHelper.width(40)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              Container(
                width: ResponsiveHelper.width(120),
                height: ResponsiveHelper.width(120),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.apartment_rounded,
                  size: ResponsiveHelper.width(60),
                  color: AppColors.primary,
                ),
              ),

              SizedBox(height: ResponsiveHelper.height(24)),

              // Title
              Text(
                'لا توجد عقارات',
                style: GoogleFonts.cairo(
                  fontSize: ResponsiveHelper.fontSize(22),
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: ResponsiveHelper.height(8)),

              // Subtitle
              Text(
                'ابدأ بإضافة عقارك الأول',
                style: GoogleFonts.tajawal(
                  fontSize: ResponsiveHelper.fontSize(15),
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
