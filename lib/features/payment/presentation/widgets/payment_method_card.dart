import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class PaymentMethodCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentMethodCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(ResponsiveHelper.width(16)),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : AppColors.white,
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: ResponsiveHelper.width(48),
              height: ResponsiveHelper.width(48),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(
                  ResponsiveHelper.radius(10),
                ),
              ),
              child: Icon(icon, color: color, size: ResponsiveHelper.width(24)),
            ),
            SizedBox(width: ResponsiveHelper.width(16)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.cairo(
                      fontSize: ResponsiveHelper.fontSize(15),
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: ResponsiveHelper.height(4)),
                  Text(
                    subtitle,
                    style: GoogleFonts.tajawal(
                      fontSize: ResponsiveHelper.fontSize(12),
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                width: ResponsiveHelper.width(24),
                height: ResponsiveHelper.width(24),
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                child: Icon(
                  Icons.check_rounded,
                  size: ResponsiveHelper.width(16),
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
