import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/consts/home_strings.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class ApartmentImageBadges extends StatelessWidget {
  final bool isVerified;
  final bool isFeatured;
  final String? badge;

  const ApartmentImageBadges({
    super.key,
    required this.isVerified,
    required this.isFeatured,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (isVerified) _buildVerifiedBadge(),
        if (badge != null) ...[
          SizedBox(height: ResponsiveHelper.height(8)),
          _buildCustomBadge(badge!),
        ],
        if (isFeatured && !isVerified) _buildFeaturedBadge(),
      ],
    );
  }

  Widget _buildVerifiedBadge() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.width(8),
        vertical: ResponsiveHelper.height(4),
      ),
      decoration: BoxDecoration(
        color: AppColors.success,
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(20)),
        boxShadow: [
          BoxShadow(
            color: AppColors.success.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.verified_rounded,
            color: AppColors.white,
            size: ResponsiveHelper.width(12),
          ),
          SizedBox(width: ResponsiveHelper.width(3)),
          Text(
            HomeStrings.verified,
            style: GoogleFonts.tajawal(
              fontSize: ResponsiveHelper.fontSize(10),
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomBadge(String text) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.width(8),
        vertical: ResponsiveHelper.height(4),
      ),
      decoration: BoxDecoration(
        color: AppColors.error,
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(20)),
        boxShadow: [
          BoxShadow(
            color: AppColors.error.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        text,
        style: GoogleFonts.cairo(
          fontSize: ResponsiveHelper.fontSize(10),
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildFeaturedBadge() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.width(8),
        vertical: ResponsiveHelper.height(4),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.amber.shade600, Colors.orange.shade600],
        ),
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.4),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star_rounded,
            color: Colors.white,
            size: ResponsiveHelper.width(12),
          ),
          SizedBox(width: ResponsiveHelper.width(3)),
          Text(
            'مميز',
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(10),
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
