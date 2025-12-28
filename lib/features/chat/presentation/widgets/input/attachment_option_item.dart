import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class AttachmentOptionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const AttachmentOptionItem({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: ResponsiveHelper.width(56),
            height: ResponsiveHelper.width(56),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: ResponsiveHelper.width(28)),
          ),
          SizedBox(height: ResponsiveHelper.height(8)),
          Text(
            label,
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(12),
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
