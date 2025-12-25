import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class OwnerApartmentCard extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const OwnerApartmentCard({
    super.key,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(bottom: ResponsiveHelper.height(12)),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.06),
                blurRadius: ResponsiveHelper.height(15),
                offset: Offset(0, ResponsiveHelper.height(4)),
              ),
            ],
          ),
          child: Column(
            children: [
              // Image Section
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(ResponsiveHelper.radius(16)),
                    ),
                    child: Container(
                      height: ResponsiveHelper.height(140),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary.withOpacity(0.08),
                            AppColors.secondary.withOpacity(0.12),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.apartment_rounded,
                          size: ResponsiveHelper.width(45),
                          color: AppColors.primary.withOpacity(0.4),
                        ),
                      ),
                    ),
                  ),
                  // Status Badge
                  Positioned(
                    top: ResponsiveHelper.height(10),
                    right: ResponsiveHelper.width(10),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveHelper.width(10),
                        vertical: ResponsiveHelper.height(5),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        borderRadius: BorderRadius.circular(
                          ResponsiveHelper.radius(20),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            color: AppColors.white,
                            size: ResponsiveHelper.width(12),
                          ),
                          SizedBox(width: ResponsiveHelper.width(4)),
                          Text(
                            'نشط',
                            style: GoogleFonts.tajawal(
                              fontSize: ResponsiveHelper.fontSize(10),
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Action Buttons
                  Positioned(
                    top: ResponsiveHelper.height(10),
                    left: ResponsiveHelper.width(10),
                    child: Row(
                      children: [
                        _buildActionButton(
                          icon: Icons.edit_rounded,
                          onTap: onEdit,
                          color: AppColors.primary,
                        ),
                        SizedBox(width: ResponsiveHelper.width(8)),
                        _buildActionButton(
                          icon: Icons.delete_rounded,
                          onTap: onDelete,
                          color: AppColors.error,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Details Section
              Padding(
                padding: EdgeInsets.all(ResponsiveHelper.width(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title & Stats
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      textDirection: TextDirection.rtl,
                      children: [
                        Expanded(
                          child: Text(
                            'شقة استوديو حديثة',
                            style: GoogleFonts.cairo(
                              fontSize: ResponsiveHelper.fontSize(15),
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveHelper.width(8),
                            vertical: ResponsiveHelper.height(4),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(
                              ResponsiveHelper.radius(8),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.visibility_rounded,
                                size: ResponsiveHelper.width(12),
                                color: Colors.blue,
                              ),
                              SizedBox(width: ResponsiveHelper.width(3)),
                              Text(
                                '245',
                                style: GoogleFonts.cairo(
                                  fontSize: ResponsiveHelper.fontSize(11),
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: ResponsiveHelper.height(6)),

                    // Location
                    Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          size: ResponsiveHelper.width(13),
                          color: Colors.grey.shade500,
                        ),
                        SizedBox(width: ResponsiveHelper.width(4)),
                        Text(
                          'مدينة نصر، القاهرة',
                          style: GoogleFonts.tajawal(
                            fontSize: ResponsiveHelper.fontSize(12),
                            color: Colors.grey.shade600,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                    SizedBox(height: ResponsiveHelper.height(10)),

                    // Price & Features
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      textDirection: TextDirection.rtl,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveHelper.width(10),
                            vertical: ResponsiveHelper.height(6),
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppColors.primary, AppColors.secondary],
                            ),
                            borderRadius: BorderRadius.circular(
                              ResponsiveHelper.radius(10),
                            ),
                          ),
                          child: Row(
                            textDirection: TextDirection.rtl,
                            children: [
                              Text(
                                '3,500',
                                style: GoogleFonts.cairo(
                                  fontSize: ResponsiveHelper.fontSize(16),
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white,
                                ),
                              ),
                              SizedBox(width: ResponsiveHelper.width(4)),
                              Text(
                                'جنيه/شهر',
                                style: GoogleFonts.tajawal(
                                  fontSize: ResponsiveHelper.fontSize(9),
                                  color: AppColors.white.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            _buildFeature(Icons.hotel_rounded, '2'),
                            SizedBox(width: ResponsiveHelper.width(8)),
                            _buildFeature(Icons.bathtub_rounded, '1'),
                            SizedBox(width: ResponsiveHelper.width(8)),
                            _buildFeature(Icons.square_foot_rounded, '80'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
        child: Icon(icon, size: ResponsiveHelper.width(16), color: color),
      ),
    );
  }

  Widget _buildFeature(IconData icon, String value) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.width(6),
        vertical: ResponsiveHelper.height(4),
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(8)),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: ResponsiveHelper.width(14),
            color: AppColors.primary,
          ),
          SizedBox(width: ResponsiveHelper.width(3)),
          Text(
            value,
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(12),
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
