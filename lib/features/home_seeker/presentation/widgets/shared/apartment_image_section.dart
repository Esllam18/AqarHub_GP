import 'package:flutter/material.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'apartment_image_badges.dart';
import 'favorite_button_widget.dart';

class ApartmentImageSection extends StatelessWidget {
  final String imageUrl;
  final bool isVerified;
  final bool isFeatured;
  final String? badge;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const ApartmentImageSection({
    super.key,
    required this.imageUrl,
    required this.isVerified,
    required this.isFeatured,
    this.badge,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildImage(),
        Positioned(
          top: ResponsiveHelper.height(10),
          right: ResponsiveHelper.width(10),
          child: ApartmentImageBadges(
            isVerified: isVerified,
            isFeatured: isFeatured,
            badge: badge,
          ),
        ),
        Positioned(
          top: ResponsiveHelper.height(10),
          left: ResponsiveHelper.width(10),
          child: FavoriteButtonWidget(
            isFavorite: isFavorite,
            onToggle: onFavoriteToggle,
          ),
        ),
      ],
    );
  }

  Widget _buildImage() {
    return ClipRRect(
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
          imageUrl,
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
    );
  }
}
