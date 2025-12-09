import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoleCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const RoleCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(ResponsiveHelper.width(20)),
        decoration: BoxDecoration(
          color: isSelected
              // ignore: deprecated_member_use
              ? AppColors.primary.withOpacity(0.1)
              : AppColors.background,
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 3,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(ResponsiveHelper.width(12)),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                    // ignore: deprecated_member_use
                    : AppColors.primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(
                  ResponsiveHelper.radius(12),
                ),
              ),
              child: Icon(
                icon,
                size: ResponsiveHelper.width(32),
                color: isSelected ? AppColors.white : AppColors.primary,
              ),
            ),
            SizedBox(width: ResponsiveHelper.width(16)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.cairo(
                      fontSize: ResponsiveHelper.fontSize(18),
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: ResponsiveHelper.height(4)),
                  Text(
                    description,
                    style: GoogleFonts.tajawal(
                      fontSize: ResponsiveHelper.fontSize(14),
                      // ignore: deprecated_member_use
                      color: AppColors.primary.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: AppColors.primary,
                size: ResponsiveHelper.width(28),
              ),
          ],
        ),
      ),
    );
  }
}
