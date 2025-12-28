import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:go_router/go_router.dart';

class AddApartmentSuccessView extends StatelessWidget {
  final bool isVerified;

  const AddApartmentSuccessView({super.key, this.isVerified = false});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(ResponsiveHelper.width(24)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Success Animation
                Container(
                  width: ResponsiveHelper.width(200),
                  height: ResponsiveHelper.width(200),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withOpacity(0.1),
                  ),
                  child: Icon(
                    Icons.check_circle_rounded,
                    size: ResponsiveHelper.width(120),
                    color: AppColors.primary,
                  ),
                ),

                SizedBox(height: ResponsiveHelper.height(32)),

                // Success Title
                Text(
                  'تم نشر العقار بنجاح! 🎉',
                  style: GoogleFonts.cairo(
                    fontSize: ResponsiveHelper.fontSize(26),
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                ),

                SizedBox(height: ResponsiveHelper.height(16)),

                // Verification Status
                if (isVerified)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveHelper.width(20),
                      vertical: ResponsiveHelper.height(12),
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary.withOpacity(0.1),
                          AppColors.secondary.withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(
                        ResponsiveHelper.radius(12),
                      ),
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      textDirection: TextDirection.rtl,
                      children: [
                        Icon(
                          Icons.verified_rounded,
                          color: AppColors.primary,
                          size: ResponsiveHelper.width(20),
                        ),
                        SizedBox(width: ResponsiveHelper.width(8)),
                        Text(
                          'العقار معتمد من الذكاء الاصطناعي',
                          style: GoogleFonts.cairo(
                            fontSize: ResponsiveHelper.fontSize(14),
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveHelper.width(20),
                      vertical: ResponsiveHelper.height(12),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(
                        ResponsiveHelper.radius(12),
                      ),
                      border: Border.all(color: Colors.orange.withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      textDirection: TextDirection.rtl,
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          color: Colors.orange,
                          size: ResponsiveHelper.width(20),
                        ),
                        SizedBox(width: ResponsiveHelper.width(8)),
                        Text(
                          'تم نشر العقار بدون شارة التحقق',
                          style: GoogleFonts.cairo(
                            fontSize: ResponsiveHelper.fontSize(14),
                            fontWeight: FontWeight.bold,
                            color: Colors.orange.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),

                SizedBox(height: ResponsiveHelper.height(24)),

                // Description
                Text(
                  'تم إضافة العقار الخاص بك بنجاح وسيظهر في قائمة العقارات',
                  style: GoogleFonts.tajawal(
                    fontSize: ResponsiveHelper.fontSize(15),
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                ),

                SizedBox(height: ResponsiveHelper.height(48)),

                // Buttons
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context.go('/owner-home');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      padding: EdgeInsets.symmetric(
                        vertical: ResponsiveHelper.height(16),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          ResponsiveHelper.radius(12),
                        ),
                      ),
                    ),
                    child: Text(
                      'العودة للرئيسية',
                      style: GoogleFonts.cairo(
                        fontSize: ResponsiveHelper.fontSize(16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: ResponsiveHelper.height(12)),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      context.push('/add-apartment');
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: BorderSide(color: AppColors.primary, width: 2),
                      padding: EdgeInsets.symmetric(
                        vertical: ResponsiveHelper.height(16),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          ResponsiveHelper.radius(12),
                        ),
                      ),
                    ),
                    child: Text(
                      'إضافة عقار آخر',
                      style: GoogleFonts.cairo(
                        fontSize: ResponsiveHelper.fontSize(16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
