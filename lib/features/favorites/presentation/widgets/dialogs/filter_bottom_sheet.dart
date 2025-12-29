import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import '../filter_option_item.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(ResponsiveHelper.radius(28)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHandleBar(),
          SizedBox(height: ResponsiveHelper.height(20)),
          _buildHeader(),
          SizedBox(height: ResponsiveHelper.height(24)),
          _buildFilterOptions(context),
          SizedBox(height: ResponsiveHelper.height(20)),
          _buildResetButton(context),
          SizedBox(height: ResponsiveHelper.height(30)),
        ],
      ),
    );
  }

  Widget _buildHandleBar() {
    return Container(
      margin: EdgeInsets.only(top: ResponsiveHelper.height(12)),
      width: ResponsiveHelper.width(50),
      height: 5,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.width(20)),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Container(
            padding: EdgeInsets.all(ResponsiveHelper.width(10)),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withOpacity(0.2),
                  AppColors.secondary.withOpacity(0.2),
                ],
              ),
              borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
            ),
            child: Icon(
              Icons.filter_list_rounded,
              color: AppColors.primary,
              size: ResponsiveHelper.width(24),
            ),
          ),
          SizedBox(width: ResponsiveHelper.width(12)),
          Text(
            'ترتيب وفلترة المفضلة',
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(20),
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterOptions(BuildContext context) {
    return Column(
      children: [
        FilterOptionItem(
          icon: Icons.access_time_rounded,
          title: 'الأحدث أولاً',
          subtitle: 'حسب تاريخ الإضافة',
          color: AppColors.primary,
          onTap: () => Navigator.pop(context),
        ),
        FilterOptionItem(
          icon: Icons.arrow_downward_rounded,
          title: 'السعر الأقل',
          subtitle: 'من الأرخص إلى الأغلى',
          color: AppColors.success,
          onTap: () => Navigator.pop(context),
        ),
        FilterOptionItem(
          icon: Icons.arrow_upward_rounded,
          title: 'السعر الأعلى',
          subtitle: 'من الأغلى إلى الأرخص',
          color: AppColors.error,
          onTap: () => Navigator.pop(context),
        ),
        FilterOptionItem(
          icon: Icons.star_rounded,
          title: 'التقييم الأعلى',
          subtitle: 'الأكثر تقييماً أولاً',
          color: Colors.amber,
          onTap: () => Navigator.pop(context),
        ),
        FilterOptionItem(
          icon: Icons.verified_rounded,
          title: 'الموثقة فقط',
          subtitle: 'عرض العقارات الموثقة',
          color: AppColors.success,
          onTap: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Widget _buildResetButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ResponsiveHelper.width(20)),
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.height(14)),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 1.5),
            borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            textDirection: TextDirection.rtl,
            children: [
              Icon(
                Icons.refresh_rounded,
                color: Colors.grey.shade700,
                size: ResponsiveHelper.width(20),
              ),
              SizedBox(width: ResponsiveHelper.width(8)),
              Text(
                'إعادة تعيين الفلاتر',
                style: GoogleFonts.tajawal(
                  fontSize: ResponsiveHelper.fontSize(14),
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
