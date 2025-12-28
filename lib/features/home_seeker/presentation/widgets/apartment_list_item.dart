import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/consts/home_strings.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class ApartmentListItem extends StatefulWidget {
  final VoidCallback onTap;
  final String title;
  final String location;
  final int price;
  final String imageUrl;
  final int bedrooms;
  final int bathrooms;
  final int area;
  final double rating;
  final int reviewCount;
  final bool isVerified;
  final bool isFeatured;
  final String? badge;

  const ApartmentListItem({
    super.key,
    required this.onTap,
    required this.title,
    required this.location,
    required this.price,
    required this.imageUrl,
    this.bedrooms = 2,
    this.bathrooms = 1,
    this.area = 80,
    this.rating = 4.8,
    this.reviewCount = 125,
    this.isVerified = true,
    this.isFeatured = false,
    this.badge,
  });

  @override
  State<ApartmentListItem> createState() => _ApartmentListItemState();
}

class _ApartmentListItemState extends State<ApartmentListItem> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: EdgeInsets.only(bottom: ResponsiveHelper.height(12)),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.06),
                blurRadius: ResponsiveHelper.height(15),
                offset: Offset(0, ResponsiveHelper.height(4)),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_buildImageSection(), _buildDetailsSection()],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Stack(
      children: [
        // Image Container
        ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(ResponsiveHelper.radius(16)),
          ),
          child: Container(
            height: ResponsiveHelper.height(140),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary.withOpacity(0.08),
                  AppColors.secondary.withOpacity(0.12),
                ],
              ),
            ),
            child: Image.network(
              widget.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                        : null,
                    color: AppColors.primary,
                    strokeWidth: 2,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Icon(
                    Icons.apartment_rounded,
                    size: ResponsiveHelper.width(40),
                    color: AppColors.primary.withOpacity(0.3),
                  ),
                );
              },
            ),
          ),
        ),

        // Verified Badge (Only if verified)
        if (widget.isVerified)
          Positioned(
            top: ResponsiveHelper.height(10),
            right: ResponsiveHelper.width(10),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.width(8),
                vertical: ResponsiveHelper.height(4),
              ),
              decoration: BoxDecoration(
                color: AppColors.success,
                borderRadius: BorderRadius.circular(
                  ResponsiveHelper.radius(20),
                ),
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
            ),
          ),

        // Custom Badge (if provided)
        if (widget.badge != null)
          Positioned(
            top: widget.isVerified
                ? ResponsiveHelper.height(45)
                : ResponsiveHelper.height(10),
            right: ResponsiveHelper.width(10),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.width(8),
                vertical: ResponsiveHelper.height(4),
              ),
              decoration: BoxDecoration(
                color: AppColors.error,
                borderRadius: BorderRadius.circular(
                  ResponsiveHelper.radius(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.error.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                widget.badge!,
                style: GoogleFonts.cairo(
                  fontSize: ResponsiveHelper.fontSize(10),
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

        // Featured Badge (if featured and not verified)
        if (widget.isFeatured && !widget.isVerified)
          Positioned(
            top: ResponsiveHelper.height(10),
            right: ResponsiveHelper.width(10),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.width(8),
                vertical: ResponsiveHelper.height(4),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.amber.shade600, Colors.orange.shade600],
                ),
                borderRadius: BorderRadius.circular(
                  ResponsiveHelper.radius(20),
                ),
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
            ),
          ),

        // Favorite Button
        Positioned(
          top: ResponsiveHelper.height(10),
          left: ResponsiveHelper.width(10),
          child: Container(
            width: ResponsiveHelper.width(32),
            height: ResponsiveHelper.width(32),
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _isFavorite = !_isFavorite;
                  });
                },
                borderRadius: BorderRadius.circular(50),
                child: Center(
                  child: Icon(
                    _isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: _isFavorite ? AppColors.error : Colors.grey.shade600,
                    size: ResponsiveHelper.width(18),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsSection() {
    return Padding(
      padding: EdgeInsets.all(ResponsiveHelper.width(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            widget.title,
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(15),
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              height: 1.2,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textDirection: TextDirection.rtl,
          ),

          SizedBox(height: ResponsiveHelper.height(6)),

          // Location
          Row(
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
                  widget.location,
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
          ),

          SizedBox(height: ResponsiveHelper.height(10)),

          // Price & Features Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textDirection: TextDirection.rtl,
            children: [
              // Price
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveHelper.width(10),
                  vertical: ResponsiveHelper.height(6),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                  ),
                  borderRadius: BorderRadius.circular(
                    ResponsiveHelper.radius(10),
                  ),
                ),
                child: Row(
                  textDirection: TextDirection.rtl,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _formatPrice(widget.price),
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
              ),

              // Features
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  _buildCompactFeature(
                    Icons.hotel_rounded,
                    widget.bedrooms.toString(),
                  ),
                  SizedBox(width: ResponsiveHelper.width(8)),
                  _buildCompactFeature(
                    Icons.bathtub_rounded,
                    widget.bathrooms.toString(),
                  ),
                  SizedBox(width: ResponsiveHelper.width(8)),
                  _buildCompactFeature(
                    Icons.square_foot_rounded,
                    widget.area.toString(),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: ResponsiveHelper.height(8)),

          // Rating
          Row(
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
                widget.rating.toStringAsFixed(1),
                style: GoogleFonts.cairo(
                  fontSize: ResponsiveHelper.fontSize(12),
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(width: ResponsiveHelper.width(4)),
              Text(
                '(${widget.reviewCount} تقييم)',
                style: GoogleFonts.tajawal(
                  fontSize: ResponsiveHelper.fontSize(10),
                  color: Colors.grey.shade500,
                ),
                textDirection: TextDirection.rtl,
              ),
            ],
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

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}
