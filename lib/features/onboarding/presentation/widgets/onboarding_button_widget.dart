import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;

  const OnboardingButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttonHeight = ResponsiveHelper.responsive<double>(
      context: context,
      mobile: 56.0,
      tablet: 64.0,
      desktop: 72.0,
    );

    final fontSize = ResponsiveHelper.responsive<double>(
      context: context,
      mobile: 16.0,
      tablet: 18.0,
      desktop: 20.0,
    );

    return SizedBox(
      height: ResponsiveHelper.height(buttonHeight),
      width: double.infinity,
      child: isOutlined
          ? _buildOutlinedButton(fontSize)
          : _buildFilledButton(fontSize),
    );
  }

  Widget _buildFilledButton(double fontSize) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.cairo(
          fontSize: ResponsiveHelper.fontSize(fontSize),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildOutlinedButton(double fontSize) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.cairo(
          fontSize: ResponsiveHelper.fontSize(fontSize),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
