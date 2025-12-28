import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class ApartmentInfoBanner extends StatelessWidget {
  const ApartmentInfoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(ResponsiveHelper.width(12)),
      padding: EdgeInsets.all(ResponsiveHelper.width(12)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.1),
            AppColors.secondary.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
        border: Border.all(color: AppColors.primary.withOpacity(0.2), width: 1),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          _buildIcon(),
          SizedBox(width: ResponsiveHelper.width(12)),
          _buildInfo(),
          _buildArrow(),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: ResponsiveHelper.width(60),
      height: ResponsiveHelper.width(60),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(10)),
      ),
      child: Icon(
        Icons.apartment_rounded,
        color: AppColors.primary,
        size: ResponsiveHelper.width(30),
      ),
    );
  }

  Widget _buildInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'شقة استوديو فاخرة',
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(14),
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textDirection: TextDirection.rtl,
          ),
          SizedBox(height: ResponsiveHelper.height(4)),
          Text(
            'مدينة نصر، القاهرة • 3,500 جنيه/شهر',
            style: GoogleFonts.tajawal(
              fontSize: ResponsiveHelper.fontSize(11),
              color: Colors.grey.shade600,
            ),
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }

  Widget _buildArrow() {
    return Icon(
      Icons.chevron_left_rounded,
      color: AppColors.primary,
      size: ResponsiveHelper.width(20),
    );
  }
}
