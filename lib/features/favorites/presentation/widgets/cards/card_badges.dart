import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class CardBadges extends StatelessWidget {
  final bool isVerified;
  final double rating;
  final VoidCallback onRemove;

  const CardBadges({
    super.key,
    required this.isVerified,
    required this.rating,
    required this.onRemove,
  });

  // ✅ Return List<Widget> instead of Stack
  List<Widget> buildBadges() {
    return [
      _buildRemoveButton(),
      if (isVerified) _buildVerifiedBadge(),
      _buildRatingBadge(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // ✅ This widget should not be used directly in the tree
    // Use buildBadges() method instead
    throw UnimplementedError(
      'CardBadges should not be used as a widget. Use buildBadges() method instead.',
    );
  }

  Widget _buildRemoveButton() {
    return Positioned(
      top: ResponsiveHelper.height(10),
      right: ResponsiveHelper.width(10),
      child: GestureDetector(
        onTap: onRemove,
        child: Container(
          width: ResponsiveHelper.width(36),
          height: ResponsiveHelper.width(36),
          decoration: BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            Icons.favorite_rounded,
            color: AppColors.error,
            size: ResponsiveHelper.width(18),
          ),
        ),
      ),
    );
  }

  Widget _buildVerifiedBadge() {
    return Positioned(
      top: ResponsiveHelper.height(10),
      left: ResponsiveHelper.width(10),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.width(8),
          vertical: ResponsiveHelper.height(4),
        ),
        decoration: BoxDecoration(
          color: AppColors.success,
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(20)),
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
              'موثق',
              style: GoogleFonts.tajawal(
                fontSize: ResponsiveHelper.fontSize(9),
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingBadge() {
    return Positioned(
      bottom: ResponsiveHelper.height(10),
      left: ResponsiveHelper.width(10),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.width(8),
          vertical: ResponsiveHelper.height(4),
        ),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(20)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.star_rounded,
              color: Colors.amber,
              size: ResponsiveHelper.width(12),
            ),
            SizedBox(width: ResponsiveHelper.width(3)),
            Text(
              rating.toString(),
              style: GoogleFonts.cairo(
                fontSize: ResponsiveHelper.fontSize(11),
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
