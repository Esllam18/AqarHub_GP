import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class BenefitItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const BenefitItem({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: ResponsiveHelper.width(16)),
        SizedBox(width: ResponsiveHelper.width(4)),
        Text(
          text,
          style: GoogleFonts.tajawal(
            fontSize: ResponsiveHelper.fontSize(11),
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
