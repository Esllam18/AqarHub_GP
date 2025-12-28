import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class ApartmentsSectionHeader extends StatelessWidget {
  final int apartmentsCount;
  final VoidCallback onFilterPressed;

  const ApartmentsSectionHeader({
    super.key,
    required this.apartmentsCount,
    required this.onFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.width(20)),
      sliver: SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textDirection: TextDirection.rtl,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'عقاراتي',
                  style: GoogleFonts.cairo(
                    fontSize: ResponsiveHelper.fontSize(22),
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: ResponsiveHelper.height(4)),
                Text(
                  '$apartmentsCount عقار',
                  style: GoogleFonts.tajawal(
                    fontSize: ResponsiveHelper.fontSize(13),
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(
                  ResponsiveHelper.radius(12),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(
                  Icons.filter_list_rounded,
                  color: AppColors.primary,
                  size: ResponsiveHelper.width(22),
                ),
                onPressed: onFilterPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
