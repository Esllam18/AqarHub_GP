import 'package:flutter/material.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'card_badges.dart';

class CardImageSection extends StatelessWidget {
  final String imageUrl;
  final bool isVerified;
  final double rating;
  final VoidCallback onRemove;

  const CardImageSection({
    super.key,
    required this.imageUrl,
    required this.isVerified,
    required this.rating,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildImage(),
        _buildGradientOverlay(),
        // ✅ Spread the badges directly into the Stack
        ...CardBadges(
          isVerified: isVerified,
          rating: rating,
          onRemove: onRemove,
        ).buildBadges(),
      ],
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(ResponsiveHelper.radius(16)),
      ),
      child: Image.network(
        imageUrl,
        height: ResponsiveHelper.height(180),
        width: double.infinity,
        fit: BoxFit.cover,
        loadingBuilder: _buildLoadingWidget,
        errorBuilder: _buildErrorWidget,
      ),
    );
  }

  Widget _buildLoadingWidget(
    BuildContext context,
    Widget child,
    ImageChunkEvent? loadingProgress,
  ) {
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
  }

  Widget _buildErrorWidget(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) {
    return Container(
      height: ResponsiveHelper.height(180),
      color: Colors.grey.shade200,
      child: Icon(
        Icons.apartment_rounded,
        size: ResponsiveHelper.width(50),
        color: Colors.grey.shade400,
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return Positioned.fill(
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
    );
  }
}
