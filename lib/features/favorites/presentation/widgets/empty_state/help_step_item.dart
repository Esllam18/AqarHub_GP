import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class HelpStepItem extends StatelessWidget {
  final String number;
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const HelpStepItem({
    super.key,
    required this.number,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.width(18)),
      decoration: _buildDecoration(),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          _buildNumberBadge(),
          SizedBox(width: ResponsiveHelper.width(16)),
          _buildContent(),
        ],
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
      border: Border.all(color: color.withOpacity(0.3), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  Widget _buildNumberBadge() {
    return Container(
      width: ResponsiveHelper.width(50),
      height: ResponsiveHelper.width(50),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [color, color.withOpacity(0.7)]),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          number,
          style: GoogleFonts.cairo(
            fontSize: ResponsiveHelper.fontSize(20),
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Icon(icon, color: color, size: ResponsiveHelper.width(18)),
              SizedBox(width: ResponsiveHelper.width(8)),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.cairo(
                    fontSize: ResponsiveHelper.fontSize(16),
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ),
            ],
          ),
          SizedBox(height: ResponsiveHelper.height(6)),
          Text(
            description,
            style: GoogleFonts.tajawal(
              fontSize: ResponsiveHelper.fontSize(13),
              color: Colors.grey.shade600,
              height: 1.5,
            ),
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }
}
