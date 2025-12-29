import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class SettingsActionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final bool isDestructive;

  const SettingsActionTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(ResponsiveHelper.width(16)),
        child: Row(
          children: [
            _buildIconContainer(),
            SizedBox(width: ResponsiveHelper.width(12)),
            Expanded(child: _buildTextContent()),
            _buildArrowIcon(),
          ],
        ),
      ),
    );
  }

  Widget _buildIconContainer() {
    final color = isDestructive ? AppColors.error : AppColors.primary;
    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.width(10)),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(10)),
      ),
      child: Icon(icon, color: color, size: ResponsiveHelper.width(24)),
    );
  }

  Widget _buildTextContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.cairo(
            fontSize: ResponsiveHelper.fontSize(15),
            fontWeight: FontWeight.w600,
            color: isDestructive ? AppColors.error : Colors.black87,
          ),
        ),
        SizedBox(height: ResponsiveHelper.height(4)),
        Text(
          subtitle,
          style: GoogleFonts.tajawal(
            fontSize: ResponsiveHelper.fontSize(12),
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildArrowIcon() {
    return Icon(
      Icons.arrow_back_ios_rounded,
      size: ResponsiveHelper.width(16),
      color: Colors.grey.shade400,
    );
  }
}
