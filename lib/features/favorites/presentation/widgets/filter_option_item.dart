import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class FilterOptionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const FilterOptionItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.width(20),
          vertical: ResponsiveHelper.height(6),
        ),
        padding: EdgeInsets.all(ResponsiveHelper.width(16)),
        decoration: _buildDecoration(),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            _buildIconContainer(),
            SizedBox(width: ResponsiveHelper.width(14)),
            _buildTextContent(),
            Icon(
              Icons.chevron_left_rounded,
              color: color,
              size: ResponsiveHelper.width(20),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      color: color.withOpacity(0.05),
      borderRadius: BorderRadius.circular(ResponsiveHelper.radius(14)),
      border: Border.all(color: color.withOpacity(0.2), width: 1),
    );
  }

  Widget _buildIconContainer() {
    return Container(
      width: ResponsiveHelper.width(50),
      height: ResponsiveHelper.width(50),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
      ),
      child: Icon(icon, color: color, size: ResponsiveHelper.width(24)),
    );
  }

  Widget _buildTextContent() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(15),
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textDirection: TextDirection.rtl,
          ),
          SizedBox(height: ResponsiveHelper.height(3)),
          Text(
            subtitle,
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
