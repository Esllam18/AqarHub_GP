import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class ProfileSectionHeader extends StatelessWidget {
  final String title;

  const ProfileSectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.width(20)),
      child: Text(
        title,
        style: GoogleFonts.cairo(
          fontSize: ResponsiveHelper.fontSize(16),
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        textDirection: TextDirection.rtl,
      ),
    );
  }
}
