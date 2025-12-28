import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class FilterBottomSheet extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterSelected;

  const FilterBottomSheet({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(ResponsiveHelper.radius(24)),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHandle(),
              Padding(
                padding: EdgeInsets.all(ResponsiveHelper.width(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle(),
                    SizedBox(height: ResponsiveHelper.height(20)),
                    _buildFilterOption(
                      'الكل',
                      Icons.apps_rounded,
                      Colors.grey.shade700,
                      'عرض جميع العقارات',
                    ),
                    _buildFilterOption(
                      'العقارات المتاحة',
                      Icons.check_circle_rounded,
                      Colors.green,
                      'العقارات الجاهزة للتأجير',
                    ),
                    _buildFilterOption(
                      'العقارات المؤجرة',
                      Icons.home_work_rounded,
                      Colors.blue,
                      'العقارات المؤجرة حالياً',
                    ),
                    _buildFilterOption(
                      'تحذيرات السعر',
                      Icons.warning_amber_rounded,
                      Colors.orange,
                      'عقارات بأسعار مشكوك فيها',
                    ),
                    SizedBox(height: ResponsiveHelper.height(12)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHandle() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: ResponsiveHelper.height(12)),
      width: ResponsiveHelper.width(40),
      height: ResponsiveHelper.height(4),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'تصفية العقارات',
      style: GoogleFonts.cairo(
        fontSize: ResponsiveHelper.fontSize(20),
        fontWeight: FontWeight.bold,
      ),
      textDirection: TextDirection.rtl,
    );
  }

  Widget _buildFilterOption(
    String label,
    IconData icon,
    Color color,
    String? description,
  ) {
    final isSelected = selectedFilter == label;

    return InkWell(
      onTap: () => onFilterSelected(label),
      borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
      child: Container(
        margin: EdgeInsets.only(bottom: ResponsiveHelper.height(8)),
        padding: EdgeInsets.all(ResponsiveHelper.width(12)),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
          border: Border.all(
            color: isSelected ? color.withOpacity(0.3) : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Container(
              padding: EdgeInsets.all(ResponsiveHelper.width(8)),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(
                  ResponsiveHelper.radius(10),
                ),
              ),
              child: Icon(icon, size: ResponsiveHelper.width(20), color: color),
            ),
            SizedBox(width: ResponsiveHelper.width(12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.cairo(
                      fontSize: ResponsiveHelper.fontSize(14),
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w600,
                      color: isSelected ? color : Colors.black87,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  if (description != null) ...[
                    SizedBox(height: ResponsiveHelper.height(2)),
                    Text(
                      description,
                      style: GoogleFonts.tajawal(
                        fontSize: ResponsiveHelper.fontSize(11),
                        color: Colors.grey.shade600,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle_rounded,
                color: color,
                size: ResponsiveHelper.width(20),
              ),
          ],
        ),
      ),
    );
  }
}
