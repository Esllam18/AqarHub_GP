import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class SettingsSwitchTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool value;
  final Function(bool) onChanged;

  const SettingsSwitchTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ResponsiveHelper.width(16)),
      child: Row(
        children: [
          _buildIconContainer(),
          SizedBox(width: ResponsiveHelper.width(12)),
          Expanded(child: _buildTextContent()),
          _buildSwitch(),
        ],
      ),
    );
  }

  Widget _buildIconContainer() {
    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.width(10)),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(10)),
      ),
      child: Icon(
        icon,
        color: AppColors.primary,
        size: ResponsiveHelper.width(24),
      ),
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
            color: Colors.black87,
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

  Widget _buildSwitch() {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeColor: AppColors.primary,
    );
  }
}
