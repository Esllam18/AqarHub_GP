import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class ChatEmptyState extends StatelessWidget {
  const ChatEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated Icon Container
          Container(
            width: ResponsiveHelper.width(140),
            height: ResponsiveHelper.width(140),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withOpacity(0.1),
                  AppColors.secondary.withOpacity(0.1),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.chat_bubble_outline_rounded,
              size: ResponsiveHelper.width(70),
              color: AppColors.primary.withOpacity(0.6),
            ),
          ),

          SizedBox(height: ResponsiveHelper.height(24)),

          // Title
          Text(
            'لا توجد محادثات بعد',
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(22),
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textDirection: TextDirection.rtl,
          ),

          SizedBox(height: ResponsiveHelper.height(12)),

          // Description
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveHelper.width(40),
            ),
            child: Text(
              'عندما تبدأ محادثة مع المالك\nستظهر جميع محادثاتك هنا',
              textAlign: TextAlign.center,
              style: GoogleFonts.tajawal(
                fontSize: ResponsiveHelper.fontSize(14),
                color: Colors.grey.shade600,
                height: 1.6,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),

          SizedBox(height: ResponsiveHelper.height(32)),

          // Action Button
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveHelper.width(32),
              vertical: ResponsiveHelper.height(14),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
              ),
              borderRadius: BorderRadius.circular(ResponsiveHelper.radius(25)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              textDirection: TextDirection.rtl,
              children: [
                Icon(
                  Icons.search_rounded,
                  color: AppColors.white,
                  size: ResponsiveHelper.width(20),
                ),
                SizedBox(width: ResponsiveHelper.width(8)),
                Text(
                  'تصفح العقارات',
                  style: GoogleFonts.cairo(
                    fontSize: ResponsiveHelper.fontSize(15),
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
