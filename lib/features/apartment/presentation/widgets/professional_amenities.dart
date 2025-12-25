import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class ProfessionalAmenities extends StatelessWidget {
  final List<Map<String, dynamic>> amenities;

  const ProfessionalAmenities({super.key, required this.amenities});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: ResponsiveHelper.width(8),
      runSpacing: ResponsiveHelper.height(8),
      textDirection: TextDirection.rtl,
      children: amenities.map((amenity) {
        return _buildAmenityChip(
          icon: amenity['icon'] as IconData,
          name: amenity['name'] as String,
        );
      }).toList(),
    );
  }

  Widget _buildAmenityChip({required IconData icon, required String name}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.width(12), // ✅ Reduced
        vertical: ResponsiveHelper.height(8), // ✅ Reduced
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.08),
            AppColors.secondary.withOpacity(0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(10)),
        border: Border.all(color: AppColors.primary.withOpacity(0.2), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        textDirection: TextDirection.rtl,
        children: [
          Container(
            padding: EdgeInsets.all(ResponsiveHelper.width(5)),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withOpacity(0.15),
                  AppColors.secondary.withOpacity(0.15),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: ResponsiveHelper.width(14), // ✅ Reduced
              color: AppColors.primary,
            ),
          ),
          SizedBox(width: ResponsiveHelper.width(6)),
          Text(
            name,
            style: GoogleFonts.tajawal(
              fontSize: ResponsiveHelper.fontSize(12), // ✅ Reduced
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }
}
