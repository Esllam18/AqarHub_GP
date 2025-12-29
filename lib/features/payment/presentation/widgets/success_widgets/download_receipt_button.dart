import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class DownloadReceiptButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DownloadReceiptButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.height(14)),
        side: BorderSide(color: AppColors.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_rounded,
            color: AppColors.primary,
            size: ResponsiveHelper.width(20),
          ),
          SizedBox(width: ResponsiveHelper.width(8)),
          Text(
            'تحميل الإيصال',
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(15),
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
