import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class PreviewImageCard extends StatelessWidget {
  final String imageUrl;
  final bool isMain;
  final String placeholderUrl;

  const PreviewImageCard({
    super.key,
    required this.imageUrl,
    required this.isMain,
    required this.placeholderUrl,
  });

  @override
  Widget build(BuildContext context) {
    final String validUrl = _isValidImageUrl(imageUrl)
        ? imageUrl
        : placeholderUrl;

    return Container(
      width: ResponsiveHelper.width(280),
      margin: EdgeInsets.only(right: ResponsiveHelper.width(12)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
        child: Stack(
          fit: StackFit.expand,
          children: [_buildImage(validUrl), if (isMain) _buildMainBadge()],
        ),
      ),
    );
  }

  Widget _buildImage(String url) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          color: Colors.grey.shade200,
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                  : null,
              valueColor: AlwaysStoppedAnimation(AppColors.primary),
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey.shade200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.broken_image_rounded,
                size: ResponsiveHelper.width(50),
                color: Colors.grey.shade400,
              ),
              SizedBox(height: ResponsiveHelper.height(8)),
              Text(
                'فشل تحميل الصورة',
                style: GoogleFonts.tajawal(
                  fontSize: ResponsiveHelper.fontSize(12),
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMainBadge() {
    return Positioned(
      top: ResponsiveHelper.height(12),
      right: ResponsiveHelper.width(12),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.width(12),
          vertical: ResponsiveHelper.height(6),
        ),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(8)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
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
              size: ResponsiveHelper.width(14),
            ),
            SizedBox(width: ResponsiveHelper.width(4)),
            Text(
              'الصورة الرئيسية',
              style: GoogleFonts.tajawal(
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

  bool _isValidImageUrl(String url) {
    if (url.isEmpty) return false;
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }
}
