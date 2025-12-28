import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class CustomStepButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isEnabled;
  final bool isPrimary;
  final IconData? icon;

  const CustomStepButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isEnabled = true,
    this.isPrimary = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    if (isPrimary) {
      return ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled ? AppColors.primary : Colors.grey.shade300,
          foregroundColor: AppColors.white,
          disabledBackgroundColor: Colors.grey.shade300,
          disabledForegroundColor: Colors.grey.shade500,
          padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.height(16)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
          ),
          elevation: isEnabled ? 2 : 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: TextDirection.rtl,
          children: [
            if (icon != null) ...[
              Icon(icon, size: ResponsiveHelper.width(20)),
              SizedBox(width: ResponsiveHelper.width(8)),
            ],
            Text(
              text,
              style: GoogleFonts.cairo(
                fontSize: ResponsiveHelper.fontSize(16),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.grey.shade700,
        side: BorderSide(color: Colors.grey.shade300, width: 2),
        padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.height(16)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.cairo(
          fontSize: ResponsiveHelper.fontSize(16),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
