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
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final TextInputAction textInputAction;
  final void Function(String)? onFieldSubmitted;
  final String? errorText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    required this.icon,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.onSaved,
    this.suffixIcon,
    this.onChanged,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      validator: validator,
      onSaved: onSaved,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      style: GoogleFonts.cairo(
        fontSize: ResponsiveHelper.fontSize(16),
        color: AppColors.primary,
      ),
      decoration: InputDecoration(
        errorText: errorText,
        labelText: label,
        hintText: hint,
        labelStyle: GoogleFonts.tajawal(
          fontSize: ResponsiveHelper.fontSize(14),
          // ignore: deprecated_member_use
          color: AppColors.primary.withOpacity(0.7),
        ),
        hintStyle: GoogleFonts.tajawal(
          fontSize: ResponsiveHelper.fontSize(14),
          // ignore: deprecated_member_use
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
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
    );
  }
}
