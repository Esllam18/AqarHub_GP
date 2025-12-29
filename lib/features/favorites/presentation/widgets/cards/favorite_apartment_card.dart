import 'package:aqar_hub_gp/features/favorites/models/favorite_apartment_model.dart';
import 'package:flutter/material.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'card_image_section.dart';
import 'card_details_section.dart';

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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: ResponsiveHelper.height(12)),
        decoration: _buildDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CardImageSection(
              imageUrl: apartment.image,
              isVerified: apartment.isVerified,
              rating: apartment.rating,
              onRemove: onRemove,
            ),
            CardDetailsSection(apartment: apartment),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 15,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}
