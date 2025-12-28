import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class ApartmentTitleBadges extends StatelessWidget {
  final String title;
  final bool isVerified;
  final double rating;
  final int reviewsCount;

  const ApartmentTitleBadges({
    super.key,
    required this.title,
    required this.isVerified,
    required this.rating,
    required this.reviewsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        SizedBox(height: ResponsiveHelper.height(10)),
        _buildBadgesRow(),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      title,
      style: GoogleFonts.cairo(
        fontSize: ResponsiveHelper.fontSize(17),
        fontWeight: FontWeight.bold,
        color: Colors.black87,
        height: 1.3,
      ),
      textDirection: TextDirection.rtl,
    );
  }

  Widget _buildBadgesRow() {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        if (isVerified) _buildVerifiedBadge(),
        if (isVerified) SizedBox(width: ResponsiveHelper.width(10)),
        _buildRatingBadge(),
      ],
    );
  }

  Widget _buildVerifiedBadge() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.width(10),
        vertical: ResponsiveHelper.height(6),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.success, AppColors.success.withOpacity(0.8)],
        ),
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(20)),
        boxShadow: [
          BoxShadow(
            color: AppColors.success.withOpacity(0.2),
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
            size: ResponsiveHelper.width(14),
          ),
          SizedBox(width: ResponsiveHelper.width(4)),
          Text(
            'موثق',
            style: GoogleFonts.tajawal(
              fontSize: ResponsiveHelper.fontSize(11),
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingBadge() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.width(10),
        vertical: ResponsiveHelper.height(6),
      ),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.1),
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(20)),
        border: Border.all(color: Colors.amber.withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star_rounded,
            color: Colors.amber,
            size: ResponsiveHelper.width(14),
          ),
          SizedBox(width: ResponsiveHelper.width(4)),
          Text(
            rating.toString(),
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(12),
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(width: ResponsiveHelper.width(4)),
          Text(
            '($reviewsCount)',
            style: GoogleFonts.tajawal(
              fontSize: ResponsiveHelper.fontSize(10),
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
