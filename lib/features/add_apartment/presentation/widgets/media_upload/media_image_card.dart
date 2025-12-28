import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class MediaImageCard extends StatelessWidget {
  final String imageUrl;
  final int index;
  final bool isMain;
  final VoidCallback onRemove;

  const MediaImageCard({
    super.key,
    required this.imageUrl,
    required this.index,
    required this.isMain,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildImageContainer(),
        if (isMain) _buildMainBadge(),
        _buildRemoveButton(),
      ],
    );
  }

  Widget _buildImageContainer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.2),
            AppColors.secondary.withOpacity(0.2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_rounded,
              size: ResponsiveHelper.width(36),
              color: AppColors.primary,
            ),
            SizedBox(height: ResponsiveHelper.height(8)),
            Text(
              'صورة ${index + 1}',
              style: GoogleFonts.tajawal(
                fontSize: ResponsiveHelper.fontSize(13),
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainBadge() {
    return Positioned(
      top: ResponsiveHelper.height(8),
      right: ResponsiveHelper.width(8),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.width(8),
          vertical: ResponsiveHelper.height(4),
        ),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(6)),
        ),
        child: Text(
          'رئيسية',
          style: GoogleFonts.tajawal(
            fontSize: ResponsiveHelper.fontSize(10),
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildRemoveButton() {
    return Positioned(
      top: ResponsiveHelper.height(8),
      left: ResponsiveHelper.width(8),
      child: GestureDetector(
        onTap: onRemove,
        child: Container(
          padding: EdgeInsets.all(ResponsiveHelper.width(4)),
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.close_rounded,
            color: AppColors.white,
            size: ResponsiveHelper.width(16),
          ),
        ),
      ),
    );
  }
}
