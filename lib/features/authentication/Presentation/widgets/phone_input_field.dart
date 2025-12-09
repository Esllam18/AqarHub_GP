import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneInputField extends StatelessWidget {
  final TextEditingController controller;
  final String? errorText;
  final Function(String)? onCountryChanged;

  const PhoneInputField({
    super.key,
    required this.controller,
    this.errorText,
    this.onCountryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'رقم الجوال',
        errorText: errorText,
        filled: true,
        fillColor: AppColors.background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
      ),
      initialCountryCode: 'EG', // Egypt as default
      style: GoogleFonts.cairo(
        fontSize: ResponsiveHelper.fontSize(16),
        color: AppColors.primary,
      ),
      dropdownTextStyle: GoogleFonts.cairo(
        fontSize: ResponsiveHelper.fontSize(14),
        color: AppColors.primary,
      ),
      onChanged: (phone) {
        if (onCountryChanged != null) {
          onCountryChanged!(phone.completeNumber);
        }
      },
    );
  }
}
