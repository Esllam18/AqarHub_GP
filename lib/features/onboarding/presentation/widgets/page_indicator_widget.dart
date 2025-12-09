import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class PageIndicatorWidget extends StatelessWidget {
  final int currentPage;
  final int pageCount;

  const PageIndicatorWidget({
    super.key,
    required this.currentPage,
    required this.pageCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
        (index) => _buildDot(index == currentPage),
      ),
    );
  }

  Widget _buildDot(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: ResponsiveHelper.width(4)),
      width: isActive ? ResponsiveHelper.width(32) : ResponsiveHelper.width(8),
      height: ResponsiveHelper.height(8),
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.primary
            // ignore: deprecated_member_use
            : AppColors.primary.withOpacity(0.3),
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(4)),
      ),
    );
  }
}
