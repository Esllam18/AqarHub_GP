import 'package:flutter/material.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class FavoriteButtonWidget extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onToggle;

  const FavoriteButtonWidget({
    super.key,
    required this.isFavorite,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          onTap: onToggle,
          borderRadius: BorderRadius.circular(50),
          child: Center(
            child: Icon(
              isFavorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: isFavorite ? AppColors.error : Colors.grey.shade600,
              size: ResponsiveHelper.width(18),
            ),
          ),
        ),
      ),
    );
  }
}
