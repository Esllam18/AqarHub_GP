import 'package:aqar_hub_gp/features/favorites/models/favorite_apartment_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'card_feature_chip.dart';

class CardDetailsSection extends StatelessWidget {
  final FavoriteApartmentModel apartment;

  const CardDetailsSection({super.key, required this.apartment});

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('ar', timeago.ArMessages());

    return Padding(
      padding: EdgeInsets.all(ResponsiveHelper.width(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitle(),
          SizedBox(height: ResponsiveHelper.height(6)),
          _buildLocation(),
          SizedBox(height: ResponsiveHelper.height(8)),
          _buildFeatures(),
          SizedBox(height: ResponsiveHelper.height(10)),
          _buildPriceAndTime(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
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
    );
  }

  Widget _buildFeatures() {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        CardFeatureChip(
          icon: Icons.hotel_rounded,
          value: apartment.bedrooms.toString(),
        ),
        SizedBox(width: ResponsiveHelper.width(6)),
        CardFeatureChip(
          icon: Icons.bathtub_rounded,
          value: apartment.bathrooms.toString(),
        ),
        SizedBox(width: ResponsiveHelper.width(6)),
        CardFeatureChip(
          icon: Icons.square_foot_rounded,
          value: '${apartment.area}م',
        ),
      ],
    );
  }

  Widget _buildPriceAndTime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      textDirection: TextDirection.rtl,
      children: [_buildPriceTag(), _buildTimeAgo()],
    );
  }

  Widget _buildPriceTag() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.width(10),
        vertical: ResponsiveHelper.height(6),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
        ),
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(8)),
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
    );
  }

  Widget _buildTimeAgo() {
    return Text(
      timeago.format(apartment.addedDate, locale: 'ar'),
      style: GoogleFonts.tajawal(
        fontSize: ResponsiveHelper.fontSize(10),
        color: Colors.grey.shade600,
      ),
      textDirection: TextDirection.rtl,
    );
  }
}
