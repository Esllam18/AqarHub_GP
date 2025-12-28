import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:aqar_hub_gp/core/router/route_names.dart';

class MyPropertiesView extends StatelessWidget {
  const MyPropertiesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded, color: AppColors.primary),
            onPressed: () => context.pop(),
          ),
          title: Text(
            'عقاراتي',
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(18),
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.add_rounded, color: AppColors.primary),
              onPressed: () {
                context.push('/${RouteNames.addApartment}');
              },
            ),
          ],
        ),
        body: ListView.builder(
          padding: EdgeInsets.all(ResponsiveHelper.width(16)),
          itemCount: 5,
          itemBuilder: (context, index) {
            return _buildPropertyCard(context, index);
          },
        ),
      ),
    );
  }

  Widget _buildPropertyCard(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: ResponsiveHelper.height(16)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(ResponsiveHelper.radius(16)),
            ),
            child: Stack(
              children: [
                Image.network(
                  'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800',
                  height: ResponsiveHelper.height(180),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: ResponsiveHelper.height(12),
                  right: ResponsiveHelper.width(12),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveHelper.width(12),
                      vertical: ResponsiveHelper.height(6),
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
                          Icons.visibility_rounded,
                          color: Colors.white,
                          size: ResponsiveHelper.width(14),
                        ),
                        SizedBox(width: ResponsiveHelper.width(4)),
                        Text(
                          'نشط',
                          style: GoogleFonts.tajawal(
                            fontSize: ResponsiveHelper.fontSize(12),
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(ResponsiveHelper.width(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'شقة فاخرة في مدينة نصر',
                  style: GoogleFonts.cairo(
                    fontSize: ResponsiveHelper.fontSize(16),
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: ResponsiveHelper.height(8)),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      size: ResponsiveHelper.width(16),
                      color: Colors.grey.shade600,
                    ),
                    SizedBox(width: ResponsiveHelper.width(4)),
                    Expanded(
                      child: Text(
                        'مدينة نصر، القاهرة',
                        style: GoogleFonts.tajawal(
                          fontSize: ResponsiveHelper.fontSize(13),
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ResponsiveHelper.height(12)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '3,500 جنيه/شهر',
                      style: GoogleFonts.cairo(
                        fontSize: ResponsiveHelper.fontSize(18),
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    Row(
                      children: [
                        _buildIconButton(
                          Icons.edit_rounded,
                          AppColors.primary,
                          () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Text(
                                    'تعديل العقار',
                                    style: GoogleFonts.tajawal(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                backgroundColor: AppColors.info,
                              ),
                            );
                          },
                        ),
                        SizedBox(width: ResponsiveHelper.width(8)),
                        _buildIconButton(
                          Icons.delete_rounded,
                          AppColors.error,
                          () {
                            _showDeleteDialog(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ResponsiveHelper.radius(8)),
      child: Container(
        padding: EdgeInsets.all(ResponsiveHelper.width(8)),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(8)),
        ),
        child: Icon(icon, color: color, size: ResponsiveHelper.width(20)),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
          ),
          title: Row(
            children: [
              Icon(
                Icons.warning_rounded,
                color: AppColors.error,
                size: ResponsiveHelper.width(24),
              ),
              SizedBox(width: ResponsiveHelper.width(12)),
              Text(
                'حذف العقار',
                style: GoogleFonts.cairo(
                  fontSize: ResponsiveHelper.fontSize(18),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            'هل أنت متأكد من حذف هذا العقار؟ لا يمكن التراجع عن هذا الإجراء.',
            style: GoogleFonts.tajawal(
              fontSize: ResponsiveHelper.fontSize(14),
              color: Colors.grey.shade700,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'إلغاء',
                style: GoogleFonts.cairo(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        'تم حذف العقار بنجاح',
                        style: GoogleFonts.tajawal(color: Colors.white),
                      ),
                    ),
                    backgroundColor: AppColors.success,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    ResponsiveHelper.radius(8),
                  ),
                ),
              ),
              child: Text(
                'حذف',
                style: GoogleFonts.cairo(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
