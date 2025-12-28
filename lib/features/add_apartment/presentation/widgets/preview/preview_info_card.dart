import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class PreviewInfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Map<String, String>? items;
  final Widget? customContent;

  const PreviewInfoCard({
    super.key,
    required this.title,
    required this.icon,
    this.items,
    this.customContent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.width(16)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: ResponsiveHelper.height(12)),
          if (customContent != null)
            customContent!
          else if (items != null)
            ...items!.entries.map(
              (entry) => _buildInfoRow(entry.key, entry.value),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Container(
          padding: EdgeInsets.all(ResponsiveHelper.width(8)),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(ResponsiveHelper.radius(8)),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: ResponsiveHelper.width(20),
          ),
        ),
        SizedBox(width: ResponsiveHelper.width(10)),
        Text(
          title,
          style: GoogleFonts.cairo(
            fontSize: ResponsiveHelper.fontSize(16),
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: ResponsiveHelper.height(8)),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.tajawal(
              fontSize: ResponsiveHelper.fontSize(13),
              color: Colors.grey.shade600,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: GoogleFonts.cairo(
                fontSize: ResponsiveHelper.fontSize(14),
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
