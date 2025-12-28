import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import '../views/owner_home_view.dart';

class OwnerApartmentCard extends StatelessWidget {
  final ApartmentData apartment;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onToggleRented;

  const OwnerApartmentCard({
    super.key,
    required this.apartment,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleRented,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(bottom: ResponsiveHelper.height(16)),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(ResponsiveHelper.radius(20)),
            border: apartment.hasSuspiciousPrice
                ? Border.all(color: Colors.orange, width: 2)
                : null,
            boxShadow: [
              BoxShadow(
                color: apartment.hasSuspiciousPrice
                    ? Colors.orange.withOpacity(0.2)
                    : AppColors.primary.withOpacity(0.06),
                blurRadius: 15,
                offset: const Offset(0, 4),
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
                      top: Radius.circular(ResponsiveHelper.radius(20)),
                    ),
                    child: Image.network(
                      apartment.imageUrl,
                      height: ResponsiveHelper.height(180),
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: ResponsiveHelper.height(180),
                          color: Colors.grey.shade200,
                          child: Icon(
                            Icons.image_not_supported,
                            size: ResponsiveHelper.width(50),
                            color: Colors.grey.shade400,
                          ),
                        );
                      },
                    ),
                  ),

                  // Gradient Overlay
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: ResponsiveHelper.height(80),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.5),
                            Colors.transparent,
                          ],
                        ),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(ResponsiveHelper.radius(20)),
                        ),
                      ),
                    ),
                  ),

                  // Status Badge
                  Positioned(
                    top: ResponsiveHelper.height(12),
                    right: ResponsiveHelper.width(12),
                    child: GestureDetector(
                      onTap: onToggleRented,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveHelper.width(12),
                          vertical: ResponsiveHelper.height(6),
                        ),
                        decoration: BoxDecoration(
                          color: apartment.isRented
                              ? Colors.blue
                              : Colors.green,
                          borderRadius: BorderRadius.circular(
                            ResponsiveHelper.radius(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  (apartment.isRented
                                          ? Colors.blue
                                          : Colors.green)
                                      .withOpacity(0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              apartment.isRented
                                  ? Icons.home_work_rounded
                                  : Icons.check_circle_rounded,
                              color: AppColors.white,
                              size: ResponsiveHelper.width(14),
                            ),
                            SizedBox(width: ResponsiveHelper.width(4)),
                            Text(
                              apartment.isRented ? 'مؤجر' : 'متاح',
                              style: GoogleFonts.cairo(
                                fontSize: ResponsiveHelper.fontSize(11),
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Price Alert Badge
                  if (apartment.hasSuspiciousPrice)
                    Positioned(
                      top: ResponsiveHelper.height(12),
                      left: ResponsiveHelper.width(12),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveHelper.width(10),
                          vertical: ResponsiveHelper.height(6),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(
                            ResponsiveHelper.radius(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.warning_amber_rounded,
                              color: AppColors.white,
                              size: ResponsiveHelper.width(14),
                            ),
                            SizedBox(width: ResponsiveHelper.width(4)),
                            Text(
                              'تحذير سعر',
                              style: GoogleFonts.cairo(
                                fontSize: ResponsiveHelper.fontSize(10),
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  // ✅ UPDATED MENU BUTTON
                  Positioned(
                    bottom: ResponsiveHelper.height(12),
                    left: ResponsiveHelper.width(12),
                    child: GestureDetector(
                      onTap: () => _showActionMenu(context),
                      child: Container(
                        width: ResponsiveHelper.width(40),
                        height: ResponsiveHelper.width(40),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.more_vert_rounded,
                          size: ResponsiveHelper.width(20),
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Details Section
              Padding(
                padding: EdgeInsets.all(ResponsiveHelper.width(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      apartment.title,
                      style: GoogleFonts.cairo(
                        fontSize: ResponsiveHelper.fontSize(17),
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textDirection: TextDirection.rtl,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: ResponsiveHelper.height(8)),

                    // Location
                    Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          size: ResponsiveHelper.width(16),
                          color: AppColors.primary,
                        ),
                        SizedBox(width: ResponsiveHelper.width(4)),
                        Expanded(
                          child: Text(
                            apartment.location,
                            style: GoogleFonts.tajawal(
                              fontSize: ResponsiveHelper.fontSize(13),
                              color: Colors.grey.shade600,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: ResponsiveHelper.height(16)),

                    // Features
                    Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        _buildFeature(
                          Icons.hotel_rounded,
                          '${apartment.bedrooms} غرفة',
                        ),
                        SizedBox(width: ResponsiveHelper.width(8)),
                        _buildFeature(
                          Icons.bathtub_rounded,
                          '${apartment.bathrooms} حمام',
                        ),
                        SizedBox(width: ResponsiveHelper.width(8)),
                        _buildFeature(
                          Icons.square_foot_rounded,
                          '${apartment.area} م²',
                        ),
                      ],
                    ),
                    SizedBox(height: ResponsiveHelper.height(16)),

                    // Price Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      textDirection: TextDirection.rtl,
                      children: [
                        Row(
                          textDirection: TextDirection.rtl,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              apartment.price.toString(),
                              style: GoogleFonts.cairo(
                                fontSize: ResponsiveHelper.fontSize(20),
                                fontWeight: FontWeight.bold,
                                color: apartment.hasSuspiciousPrice
                                    ? Colors.orange
                                    : AppColors.primary,
                              ),
                            ),
                            SizedBox(width: ResponsiveHelper.width(4)),
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: ResponsiveHelper.height(2),
                              ),
                              child: Text(
                                'جنيه/شهر',
                                style: GoogleFonts.tajawal(
                                  fontSize: ResponsiveHelper.fontSize(11),
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveHelper.width(12),
                            vertical: ResponsiveHelper.height(6),
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(
                              ResponsiveHelper.radius(8),
                            ),
                          ),
                          child: Text(
                            'للإيجار',
                            style: GoogleFonts.cairo(
                              fontSize: ResponsiveHelper.fontSize(12),
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Price Warning Message
                    if (apartment.hasSuspiciousPrice) ...[
                      SizedBox(height: ResponsiveHelper.height(12)),
                      Container(
                        padding: EdgeInsets.all(ResponsiveHelper.width(10)),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(
                            ResponsiveHelper.radius(10),
                          ),
                          border: Border.all(
                            color: Colors.orange.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              size: ResponsiveHelper.width(16),
                              color: Colors.orange.shade700,
                            ),
                            SizedBox(width: ResponsiveHelper.width(8)),
                            Expanded(
                              child: Text(
                                'السعر أعلى من متوسط المنطقة بـ 55%',
                                style: GoogleFonts.tajawal(
                                  fontSize: ResponsiveHelper.fontSize(11),
                                  color: Colors.orange.shade700,
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeature(IconData icon, String text) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.height(8)),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(10)),
          border: Border.all(color: Colors.grey.shade200, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: ResponsiveHelper.width(16),
              color: Colors.grey.shade700,
            ),
            SizedBox(width: ResponsiveHelper.width(4)),
            Flexible(
              child: Text(
                text,
                style: GoogleFonts.cairo(
                  fontSize: ResponsiveHelper.fontSize(11),
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ NEW BEAUTIFUL ACTION MENU
  void _showActionMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(ResponsiveHelper.radius(24)),
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle Bar
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: ResponsiveHelper.height(12),
                  ),
                  width: ResponsiveHelper.width(40),
                  height: ResponsiveHelper.height(4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                // Header
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveHelper.width(20),
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Container(
                        padding: EdgeInsets.all(ResponsiveHelper.width(10)),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(
                            ResponsiveHelper.radius(12),
                          ),
                        ),
                        child: Icon(
                          Icons.apartment_rounded,
                          color: AppColors.primary,
                          size: ResponsiveHelper.width(24),
                        ),
                      ),
                      SizedBox(width: ResponsiveHelper.width(12)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              apartment.title,
                              style: GoogleFonts.cairo(
                                fontSize: ResponsiveHelper.fontSize(16),
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              apartment.location,
                              style: GoogleFonts.tajawal(
                                fontSize: ResponsiveHelper.fontSize(12),
                                color: Colors.grey.shade600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: ResponsiveHelper.height(20)),

                // Action Options
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveHelper.width(20),
                  ),
                  child: Column(
                    children: [
                      _buildActionOption(
                        context,
                        icon: apartment.isRented
                            ? Icons.check_circle_rounded
                            : Icons.home_work_rounded,
                        title: apartment.isRented
                            ? 'تحديد كمتاح'
                            : 'تحديد كمؤجر',
                        subtitle: apartment.isRented
                            ? 'إظهار العقار كمتاح للتأجير'
                            : 'تحديد العقار كمؤجر',
                        color: apartment.isRented ? Colors.green : Colors.blue,
                        onTap: () {
                          Navigator.pop(context);
                          onToggleRented();
                        },
                      ),
                      _buildActionOption(
                        context,
                        icon: Icons.edit_rounded,
                        title: 'تعديل العقار',
                        subtitle: 'تعديل معلومات وصور العقار',
                        color: AppColors.primary,
                        onTap: () {
                          Navigator.pop(context);
                          onEdit();
                        },
                      ),
                      _buildActionOption(
                        context,
                        icon: Icons.share_rounded,
                        title: 'مشاركة',
                        subtitle: 'مشاركة العقار مع الآخرين',
                        color: Colors.orange,
                        onTap: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'مشاركة العقار',
                                style: GoogleFonts.tajawal(),
                                textDirection: TextDirection.rtl,
                              ),
                              backgroundColor: Colors.orange,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      ),
                      _buildActionOption(
                        context,
                        icon: Icons.delete_rounded,
                        title: 'حذف العقار',
                        subtitle: 'حذف العقار بشكل نهائي',
                        color: AppColors.error,
                        onTap: () {
                          Navigator.pop(context);
                          onDelete();
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: ResponsiveHelper.height(20)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
      child: Container(
        margin: EdgeInsets.only(bottom: ResponsiveHelper.height(12)),
        padding: EdgeInsets.all(ResponsiveHelper.width(14)),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
          border: Border.all(color: color.withOpacity(0.2), width: 1),
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Container(
              padding: EdgeInsets.all(ResponsiveHelper.width(10)),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(
                  ResponsiveHelper.radius(10),
                ),
              ),
              child: Icon(icon, color: color, size: ResponsiveHelper.width(22)),
            ),
            SizedBox(width: ResponsiveHelper.width(14)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.cairo(
                      fontSize: ResponsiveHelper.fontSize(14),
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: ResponsiveHelper.height(2)),
                  Text(
                    subtitle,
                    style: GoogleFonts.tajawal(
                      fontSize: ResponsiveHelper.fontSize(11),
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_back_ios_rounded,
              size: ResponsiveHelper.width(16),
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}
