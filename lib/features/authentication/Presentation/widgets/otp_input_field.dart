import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Function(String)? onChanged;

  const OtpInputField({
    super.key,
    required this.controller,
    this.focusNode,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: ResponsiveHelper.width(56),
            maxHeight: ResponsiveHelper.height(56),
          ),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(24),
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              counterText: '',
              filled: true,
              fillColor: AppColors.background,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  ResponsiveHelper.radius(12),
                ),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  ResponsiveHelper.radius(12),
                ),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  ResponsiveHelper.radius(12),
                ),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 2,
                ),
              ),
            ),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
