import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/consts/home_strings.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final bool isOwner;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.isOwner,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // RTL for entire nav bar
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: ResponsiveHelper.height(12),
              offset: Offset(0, ResponsiveHelper.height(-3)),
            ),
          ],
        ),
        child: SafeArea(
          child: Container(
            height: ResponsiveHelper.height(70),
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveHelper.width(8),
              vertical: ResponsiveHelper.height(6),
            ),
            child: isOwner ? _buildOwnerNavBar() : _buildUserNavBar(),
          ),
        ),
      ),
    );
  }

  Widget _buildUserNavBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      textDirection: TextDirection.rtl, // RTL for user nav bar
      children: [
        _buildNavItem(
          icon: Icons.home_rounded,
          label: HomeStrings.navHome,
          index: 0,
        ),
        _buildNavItem(
          icon: Icons.chat_bubble_rounded,
          label: HomeStrings.navChats,
          index: 1,
        ),
        _buildNavItem(
          icon: Icons.favorite_rounded,
          label: HomeStrings.navFavorites,
          index: 2,
        ),
        _buildNavItem(
          icon: Icons.person_rounded,
          label: HomeStrings.navProfile,
          index: 3,
        ),
      ],
    );
  }

  Widget _buildOwnerNavBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      textDirection: TextDirection.rtl, // RTL for owner nav bar
      children: [
        _buildNavItem(
          icon: Icons.dashboard_rounded,
          label: HomeStrings.navDashboard,
          index: 0,
        ),
        SizedBox(width: ResponsiveHelper.width(60)), // Space for FAB
        _buildNavItem(
          icon: Icons.chat_bubble_rounded,
          label: HomeStrings.navChats,
          index: 1,
        ),
        _buildNavItem(
          icon: Icons.person_rounded,
          label: HomeStrings.navProfile,
          index: 2,
        ),
      ],
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isSelected = currentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
        splashColor: AppColors.primary.withOpacity(0.1),
        highlightColor: AppColors.primary.withOpacity(0.05),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.height(6)),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary.withOpacity(0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon with animation
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                child: Icon(
                  icon,
                  color: isSelected ? AppColors.primary : Colors.grey.shade600,
                  size: ResponsiveHelper.width(isSelected ? 25 : 23),
                ),
              ),
              SizedBox(height: ResponsiveHelper.height(3)),
              // Label with Tajawal font and RTL
              Flexible(
                child: Text(
                  label,
                  style: GoogleFonts.tajawal(
                    fontSize: ResponsiveHelper.fontSize(10),
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected
                        ? AppColors.primary
                        : Colors.grey.shade600,
                    height: 1.1,
                  ),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl, // RTL for label text
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
