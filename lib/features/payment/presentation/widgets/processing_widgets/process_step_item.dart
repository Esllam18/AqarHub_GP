import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class ProcessStepItem extends StatelessWidget {
  final String text;
  final bool isActive;

  const ProcessStepItem({
    super.key,
    required this.text,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildIndicator(),
        SizedBox(width: ResponsiveHelper.width(12)),
        Text(
          text,
          style: GoogleFonts.tajawal(
            fontSize: ResponsiveHelper.fontSize(14),
            color: isActive ? Colors.black87 : Colors.grey.shade500,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildIndicator() {
    return Container(
      width: ResponsiveHelper.width(24),
      height: ResponsiveHelper.width(24),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? AppColors.primary : Colors.grey.shade300,
      ),
      child: isActive
          ? Icon(
              Icons.check_rounded,
              size: ResponsiveHelper.width(16),
              color: Colors.white,
            )
          : null,
    );
  }
}
