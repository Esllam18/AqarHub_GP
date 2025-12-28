import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class ActiveFilterChip extends StatelessWidget {
  final String selectedFilter;
  final VoidCallback onClear;

  const ActiveFilterChip({
    super.key,
    required this.selectedFilter,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.width(20)),
      sliver: SliverToBoxAdapter(
        child: Container(
          margin: EdgeInsets.only(bottom: ResponsiveHelper.height(16)),
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveHelper.width(12),
            vertical: ResponsiveHelper.height(8),
          ),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(ResponsiveHelper.radius(10)),
            border: Border.all(color: AppColors.primary.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            textDirection: TextDirection.rtl,
            children: [
              Icon(
                Icons.filter_alt_rounded,
                size: ResponsiveHelper.width(16),
                color: AppColors.primary,
              ),
              SizedBox(width: ResponsiveHelper.width(6)),
              Text(
                'تصفية: $selectedFilter',
                style: GoogleFonts.cairo(
                  fontSize: ResponsiveHelper.fontSize(13),
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: ResponsiveHelper.width(8)),
              GestureDetector(
                onTap: onClear,
                child: Icon(
                  Icons.close_rounded,
                  size: ResponsiveHelper.width(16),
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
