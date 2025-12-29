import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class ReportButton extends StatelessWidget {
  final VoidCallback onTap;

  const ReportButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.height(16)),
        decoration: BoxDecoration(
          color: AppColors.error.withOpacity(0.1),
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
          border: Border.all(color: AppColors.error.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.report_problem_rounded,
              color: AppColors.error,
              size: ResponsiveHelper.width(22),
            ),
            SizedBox(width: ResponsiveHelper.width(12)),
            Text(
              'الإبلاغ عن مشكلة',
              style: GoogleFonts.cairo(
                fontSize: ResponsiveHelper.fontSize(15),
                fontWeight: FontWeight.bold,
                color: AppColors.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
