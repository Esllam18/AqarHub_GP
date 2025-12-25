import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class PremiumPriceCard extends StatelessWidget {
  final int price;
  final int bedrooms;
  final int bathrooms;
  final int area;

  const PremiumPriceCard({
    super.key,
    required this.price,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.width(14)), // ✅ Reduced
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
        ),
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(14)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Price Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textDirection: TextDirection.rtl,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'السعر الشهري',
                    style: GoogleFonts.tajawal(
                      fontSize: ResponsiveHelper.fontSize(11),
                      color: AppColors.white.withOpacity(0.85),
                      fontWeight: FontWeight.w500,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(height: ResponsiveHelper.height(3)),
                  Row(
                    textDirection: TextDirection.rtl,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        price.toString(),
                        style: GoogleFonts.cairo(
                          fontSize: ResponsiveHelper.fontSize(24), // ✅ Reduced
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                          height: 1,
                        ),
                      ),
                      SizedBox(width: ResponsiveHelper.width(5)),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: ResponsiveHelper.height(3),
                        ),
                        child: Text(
                          'جنيه/شهر',
                          style: GoogleFonts.tajawal(
                            fontSize: ResponsiveHelper.fontSize(11),
                            fontWeight: FontWeight.w600,
                            color: AppColors.white.withOpacity(0.9),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(ResponsiveHelper.width(10)),
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.payments_rounded,
                  color: AppColors.white,
                  size: ResponsiveHelper.width(20),
                ),
              ),
            ],
          ),

          SizedBox(height: ResponsiveHelper.height(12)),

          // Divider
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  AppColors.white.withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          SizedBox(height: ResponsiveHelper.height(12)),

          // Features Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            textDirection: TextDirection.rtl,
            children: [
              _buildFeature(
                icon: Icons.hotel_rounded,
                value: bedrooms.toString(),
                label: 'غرف',
              ),
              _buildDivider(),
              _buildFeature(
                icon: Icons.bathtub_rounded,
                value: bathrooms.toString(),
                label: 'حمام',
              ),
              _buildDivider(),
              _buildFeature(
                icon: Icons.square_foot_rounded,
                value: area.toString(),
                label: 'متر²',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeature({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppColors.white,
          size: ResponsiveHelper.width(20), // ✅ Reduced
        ),
        SizedBox(height: ResponsiveHelper.height(4)),
        Text(
          value,
          style: GoogleFonts.cairo(
            fontSize: ResponsiveHelper.fontSize(16), // ✅ Reduced
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.tajawal(
            fontSize: ResponsiveHelper.fontSize(10),
            color: AppColors.white.withOpacity(0.9),
          ),
          textDirection: TextDirection.rtl,
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: ResponsiveHelper.height(45),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            AppColors.white.withOpacity(0.3),
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}
