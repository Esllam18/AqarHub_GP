import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final IconData icon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? errorText;
  final Widget? suffixIcon;
  final Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    required this.icon,
    this.keyboardType,
    this.obscureText = false,
    this.errorText,
    this.suffixIcon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      style: GoogleFonts.cairo(
        fontSize: ResponsiveHelper.fontSize(16),
        color: AppColors.primary,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        errorText: errorText,
        labelStyle: GoogleFonts.tajawal(
          fontSize: ResponsiveHelper.fontSize(14),
          color: AppColors.primary.withOpacity(0.7),
        ),
        hintStyle: GoogleFonts.tajawal(
          fontSize: ResponsiveHelper.fontSize(14),
          color: AppColors.primary.withOpacity(0.4),
        ),
        prefixIcon: Icon(
          icon,
          color: AppColors.primary,
          size: ResponsiveHelper.width(24),
        ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: AppColors.background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
      ),
    );
  }
}
