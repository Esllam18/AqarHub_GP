import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class OwnerHeaderWidget extends StatelessWidget {
  const OwnerHeaderWidget({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'صباح الخير';
    if (hour < 18) return 'مساء الخير';
    return 'مساء الخير';
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [AppColors.primary, AppColors.secondary],
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(ResponsiveHelper.radius(20)),
            bottomRight: Radius.circular(ResponsiveHelper.radius(20)),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(ResponsiveHelper.width(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textDirection: TextDirection.rtl,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getGreeting(),
                      style: GoogleFonts.tajawal(
                        fontSize: ResponsiveHelper.fontSize(13),
                        color: AppColors.white.withOpacity(0.9),
                      ),
                    ),
                    SizedBox(height: ResponsiveHelper.height(4)),
                    Text(
                      'أهلاً بك في عقار هاب',
                      style: GoogleFonts.cairo(
                        fontSize: ResponsiveHelper.fontSize(20),
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: ResponsiveHelper.height(4)),
                    Text(
                      'إدارة عقاراتك من هنا',
                      style: GoogleFonts.tajawal(
                        fontSize: ResponsiveHelper.fontSize(12),
                        color: AppColors.white.withOpacity(0.85),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: ResponsiveHelper.width(44),
                  height: ResponsiveHelper.width(44),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.notifications_none_rounded,
                      color: AppColors.primary,
                      size: ResponsiveHelper.width(24),
                    ),
                    onPressed: () {},
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
