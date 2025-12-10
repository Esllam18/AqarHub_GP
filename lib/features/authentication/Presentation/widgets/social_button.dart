import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SocialButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final String? imagePath;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;

  const SocialButton({
    super.key,
    required this.text,
    this.icon,
    this.imagePath,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
  }) : assert(
         icon != null || imagePath != null,
         'Either icon or imagePath must be provided',
       );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: ResponsiveHelper.height(56),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                text,
                style: GoogleFonts.cairo(
                  fontSize: ResponsiveHelper.fontSize(16),
                  fontWeight: FontWeight.w700,
                  color: textColor ?? AppColors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: ResponsiveHelper.width(12)),
            if (imagePath != null)
              imagePath!.startsWith('http')
                  ? Image.network(
                      imagePath!,
                      width: ResponsiveHelper.width(24),
                      height: ResponsiveHelper.height(24),
                    )
                  : Image.asset(
                      imagePath!,
                      width: ResponsiveHelper.width(24),
                      height: ResponsiveHelper.height(24),
                    )
            else
              Icon(
                icon,
                size: ResponsiveHelper.width(24),
                color: textColor ?? AppColors.white,
              ),
          ],
        ),
      ),
    );
  }
}
