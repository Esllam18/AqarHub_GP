import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class OwnerStatsSection extends StatelessWidget {
  final int totalApartments;
  final int availableCount;
  final int rentedCount;

  const OwnerStatsSection({
    super.key,
    required this.totalApartments,
    required this.availableCount,
    required this.rentedCount,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.fromLTRB(
          ResponsiveHelper.width(20),
          ResponsiveHelper.height(20),
          ResponsiveHelper.width(20),
          ResponsiveHelper.height(16),
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            _buildStatCard(
              '$totalApartments',
              'إجمالي العقارات',
              Icons.apartment_rounded,
              AppColors.primary,
            ),
            SizedBox(width: ResponsiveHelper.width(10)),
            _buildStatCard(
              '$availableCount',
              'متاح',
              Icons.check_circle_rounded,
              Colors.green,
            ),
            SizedBox(width: ResponsiveHelper.width(10)),
            _buildStatCard(
              '$rentedCount',
              'مؤجر',
              Icons.home_work_rounded,
              Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String value,
    String label,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(ResponsiveHelper.width(14)),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: color.withOpacity(0.2), width: 1.5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(ResponsiveHelper.width(8)),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: ResponsiveHelper.width(20)),
            ),
            SizedBox(height: ResponsiveHelper.height(8)),
            Text(
              value,
              style: GoogleFonts.cairo(
                fontSize: ResponsiveHelper.fontSize(20),
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: ResponsiveHelper.height(2)),
            Text(
              label,
              style: GoogleFonts.tajawal(
                fontSize: ResponsiveHelper.fontSize(11),
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
