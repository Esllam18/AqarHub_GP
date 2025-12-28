import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class PreviewPriceCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const PreviewPriceCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.width(20)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
        ),
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data['category'] == 'rent' ? 'الإيجار الشهري' : 'سعر البيع',
                style: GoogleFonts.tajawal(
                  fontSize: ResponsiveHelper.fontSize(14),
                  color: AppColors.white.withOpacity(0.9),
                ),
                textDirection: TextDirection.rtl,
              ),
              SizedBox(height: ResponsiveHelper.height(4)),
              Text(
                '${data['price'] ?? 0} جنيه',
                style: GoogleFonts.cairo(
                  fontSize: ResponsiveHelper.fontSize(28),
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
          if (data['isVerified'] == true) _buildVerificationBadge(),
        ],
      ),
    );
  }

  Widget _buildVerificationBadge() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.width(12),
        vertical: ResponsiveHelper.height(8),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(10)),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.verified_rounded,
            color: AppColors.primary,
            size: ResponsiveHelper.width(18),
          ),
          SizedBox(width: ResponsiveHelper.width(4)),
          Text(
            'معتمد',
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(13),
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
