import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../models/favorite_apartment_model.dart';

class FavoriteApartmentCard extends StatelessWidget {
  final FavoriteApartmentModel apartment;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const FavoriteApartmentCard({
    super.key,
    required this.apartment,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    // Configure Arabic locale for timeago
    timeago.setLocaleMessages('ar', timeago.ArMessages());

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: ResponsiveHelper.height(12)),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // ✅ Fixed: Set to min
          children: [
            // Image Section with Fixed Height
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(ResponsiveHelper.radius(16)),
                  ),
                  child: Image.network(
                    apartment.image,
                    height: ResponsiveHelper.height(180), // ✅ Fixed height
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: ResponsiveHelper.height(180),
                        color: Colors.grey.shade200,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: ResponsiveHelper.height(180),
                        color: Colors.grey.shade200,
                        child: Icon(
                          Icons.apartment_rounded,
                          size: ResponsiveHelper.width(50),
                          color: Colors.grey.shade400,
                        ),
                      );
                    },
                  ),
                ),

                // Gradient Overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(ResponsiveHelper.radius(16)),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.4),
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),
                ),

                // Remove Button
                Positioned(
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
                ),

                // Verified Badge
                if (apartment.isVerified)
                  Positioned(
                    top: ResponsiveHelper.height(10),
                    left: ResponsiveHelper.width(10),
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
                  ),

                // Rating
                Positioned(
                  bottom: ResponsiveHelper.height(10),
                  left: ResponsiveHelper.width(10),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveHelper.width(8),
                      vertical: ResponsiveHelper.height(4),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(
                        ResponsiveHelper.radius(20),
                      ),
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
                          apartment.rating.toString(),
                          style: GoogleFonts.cairo(
                            fontSize: ResponsiveHelper.fontSize(11),
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Details Section with Fixed Padding
            Padding(
              padding: EdgeInsets.all(ResponsiveHelper.width(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // ✅ Fixed
                children: [
                  // Title
                  Text(
                    apartment.title,
                    style: GoogleFonts.cairo(
                      fontSize: ResponsiveHelper.fontSize(14),
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                    textDirection: TextDirection.rtl,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
                      SizedBox(width: ResponsiveHelper.width(3)),
                      Expanded(
                        child: Text(
                          apartment.location,
                          style: GoogleFonts.tajawal(
                            fontSize: ResponsiveHelper.fontSize(11),
                            color: Colors.grey.shade600,
                          ),
                          textDirection: TextDirection.rtl,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: ResponsiveHelper.height(8)),

                  // Features
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      _buildFeature(
                        Icons.hotel_rounded,
                        apartment.bedrooms.toString(),
                      ),
                      SizedBox(width: ResponsiveHelper.width(6)),
                      _buildFeature(
                        Icons.bathtub_rounded,
                        apartment.bathrooms.toString(),
                      ),
                      SizedBox(width: ResponsiveHelper.width(6)),
                      _buildFeature(
                        Icons.square_foot_rounded,
                        '${apartment.area}م',
                      ),
                    ],
                  ),

                  SizedBox(height: ResponsiveHelper.height(10)),

                  // Price & Time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    textDirection: TextDirection.rtl,
                    children: [
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
                            ResponsiveHelper.radius(8),
                          ),
                        ),
                        child: Row(
                          textDirection: TextDirection.rtl,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              apartment.price.toString(),
                              style: GoogleFonts.cairo(
                                fontSize: ResponsiveHelper.fontSize(14),
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              ),
                            ),
                            SizedBox(width: ResponsiveHelper.width(3)),
                            Text(
                              'جنيه',
                              style: GoogleFonts.tajawal(
                                fontSize: ResponsiveHelper.fontSize(9),
                                color: AppColors.white.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        timeago.format(apartment.addedDate, locale: 'ar'),
                        style: GoogleFonts.tajawal(
                          fontSize: ResponsiveHelper.fontSize(10),
                          color: Colors.grey.shade600,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature(IconData icon, String value) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.width(6),
        vertical: ResponsiveHelper.height(4),
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(6)),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: ResponsiveHelper.width(12),
            color: AppColors.primary,
          ),
          SizedBox(width: ResponsiveHelper.width(3)),
          Text(
            value,
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(11),
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
