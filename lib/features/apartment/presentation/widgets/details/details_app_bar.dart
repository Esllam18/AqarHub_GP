import 'package:flutter/material.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class DetailsAppBar extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onBack;
  final VoidCallback onShare;
  final VoidCallback onFavoriteToggle;

  const DetailsAppBar({
    super.key,
    required this.isFavorite,
    required this.onBack,
    required this.onShare,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black.withOpacity(0.6), Colors.transparent],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveHelper.width(16),
              vertical: ResponsiveHelper.height(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textDirection: TextDirection.rtl,
              children: [
                _buildActionButton(
                  icon: Icons.arrow_forward_ios,
                  onTap: onBack,
                ),
                Row(
                  children: [
                    _buildActionButton(
                      icon: Icons.share_rounded,
                      onTap: onShare,
                    ),
                    SizedBox(width: ResponsiveHelper.width(12)),
                    _buildActionButton(
                      icon: isFavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      onTap: onFavoriteToggle,
                      color: isFavorite ? AppColors.error : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onTap,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: ResponsiveHelper.width(42),
        height: ResponsiveHelper.width(42),
        decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: color ?? Colors.black87,
          size: ResponsiveHelper.width(22),
        ),
      ),
    );
  }
}
