import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class HelpFeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const HelpFeatureTile({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.width(16)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          _buildIconContainer(),
          SizedBox(width: ResponsiveHelper.width(14)),
          _buildTextContent(),
        ],
      ),
    );
  }

  Widget _buildIconContainer() {
    return Container(
      width: ResponsiveHelper.width(44),
      height: ResponsiveHelper.width(44),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(10)),
      ),
      child: Icon(icon, color: color, size: ResponsiveHelper.width(22)),
    );
  }

  Widget _buildTextContent() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(14),
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textDirection: TextDirection.rtl,
          ),
          SizedBox(height: ResponsiveHelper.height(3)),
          Text(
            description,
            style: GoogleFonts.tajawal(
              fontSize: ResponsiveHelper.fontSize(12),
              color: Colors.grey.shade600,
            ),
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }
}
