import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class ApartmentDetailsSection extends StatelessWidget {
  final String title;
  final String location;
  final int price;
  final int bedrooms;
  final int bathrooms;
  final int area;
  final double rating;
  final int reviewCount;

  const ApartmentDetailsSection({
    super.key,
    required this.title,
    required this.location,
    required this.price,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.rating,
    required this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ResponsiveHelper.width(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          SizedBox(height: ResponsiveHelper.height(6)),
          _buildLocation(),
          SizedBox(height: ResponsiveHelper.height(10)),
          _buildPriceAndFeatures(),
          SizedBox(height: ResponsiveHelper.height(8)),
          _buildRating(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      title,
      style: GoogleFonts.cairo(
        fontSize: ResponsiveHelper.fontSize(15),
        fontWeight: FontWeight.bold,
        color: Colors.black87,
        height: 1.2,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textDirection: TextDirection.rtl,
    );
  }

  Widget _buildLocation() {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Icon(
          Icons.location_on_rounded,
          size: ResponsiveHelper.width(13),
          color: Colors.grey.shade500,
        ),
        SizedBox(width: ResponsiveHelper.width(4)),
        Expanded(
          child: Text(
            location,
            style: GoogleFonts.tajawal(
              fontSize: ResponsiveHelper.fontSize(12),
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textDirection: TextDirection.rtl,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceAndFeatures() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      textDirection: TextDirection.rtl,
      children: [
        _buildPrice(),
        Row(
          textDirection: TextDirection.rtl,
          children: [
            _buildCompactFeature(Icons.hotel_rounded, bedrooms.toString()),
            SizedBox(width: ResponsiveHelper.width(8)),
            _buildCompactFeature(Icons.bathtub_rounded, bathrooms.toString()),
            SizedBox(width: ResponsiveHelper.width(8)),
            _buildCompactFeature(Icons.square_foot_rounded, area.toString()),
          ],
        ),
      ],
    );
  }

  Widget _buildPrice() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.width(10),
        vertical: ResponsiveHelper.height(6),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
        ),
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(10)),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _formatPrice(price),
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(16),
              fontWeight: FontWeight.bold,
              color: AppColors.white,
              height: 1,
            ),
          ),
          SizedBox(width: ResponsiveHelper.width(4)),
          Text(
            'جنيه/شهر',
            style: GoogleFonts.tajawal(
              fontSize: ResponsiveHelper.fontSize(9),
              fontWeight: FontWeight.w600,
              color: AppColors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactFeature(IconData icon, String value) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.width(6),
        vertical: ResponsiveHelper.height(4),
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(8)),
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: ResponsiveHelper.width(14),
            color: AppColors.primary,
          ),
          SizedBox(width: ResponsiveHelper.width(3)),
          Text(
            value,
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(12),
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRating() {
    return Row(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          Icons.star_rounded,
          color: Colors.amber.shade600,
          size: ResponsiveHelper.width(14),
        ),
        SizedBox(width: ResponsiveHelper.width(3)),
        Text(
          rating.toStringAsFixed(1),
          style: GoogleFonts.cairo(
            fontSize: ResponsiveHelper.fontSize(12),
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(width: ResponsiveHelper.width(4)),
        Text(
          '($reviewCount تقييم)',
          style: GoogleFonts.tajawal(
            fontSize: ResponsiveHelper.fontSize(10),
            color: Colors.grey.shade500,
          ),
          textDirection: TextDirection.rtl,
        ),
      ],
    );
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}
