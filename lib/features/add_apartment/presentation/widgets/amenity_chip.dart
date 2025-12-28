import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class AmenitySelectionChip extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const AmenitySelectionChip({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.width(14),
          vertical: ResponsiveHelper.height(10),
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          textDirection: TextDirection.rtl,
          children: [
            Icon(
              icon,
              size: ResponsiveHelper.width(18),
              color: isSelected ? AppColors.white : AppColors.primary,
            ),
            SizedBox(width: ResponsiveHelper.width(6)),
            Text(
              title,
              style: GoogleFonts.tajawal(
                fontSize: ResponsiveHelper.fontSize(13),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                color: isSelected ? AppColors.white : Colors.black87,
              ),
            ),
            if (isSelected) ...[
              SizedBox(width: ResponsiveHelper.width(6)),
              Icon(
                Icons.check_circle_rounded,
                size: ResponsiveHelper.width(16),
                color: AppColors.white,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
