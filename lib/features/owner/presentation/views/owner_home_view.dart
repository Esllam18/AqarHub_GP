import 'package:aqar_hub_gp/core/router/route_names.dart';
import 'package:aqar_hub_gp/core/strings/owner_strings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:go_router/go_router.dart';
import '../widgets/owner_apartment_card.dart';

class OwnerHomeView extends StatelessWidget {
  const OwnerHomeView({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'صباح الخير';
    } else {
      return 'مساء الخير';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: CustomScrollView(
          slivers: [
            // Premium Owner Header (FIXED)
            SliverAppBar(
              expandedHeight: ResponsiveHelper.responsive(
                context: context,
                mobile: 180, // ✅ Increased from 140 to 180
                tablet: 200,
              ),
              floating: true,
              snap: true,
              pinned: false,
              backgroundColor: AppColors.primary,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.primary, AppColors.secondary],
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveHelper.width(20),
                        vertical: ResponsiveHelper.height(
                          10,
                        ), // ✅ Reduced from 12
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            textDirection: TextDirection.rtl,
                            children: [
                              // Welcome Section
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _getGreeting(),
                                      style: GoogleFonts.tajawal(
                                        fontSize: ResponsiveHelper.fontSize(13),
                                        color: AppColors.white.withOpacity(
                                          0.85,
                                        ),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textDirection: TextDirection.rtl,
                                    ),
                                    SizedBox(
                                      height: ResponsiveHelper.height(3),
                                    ), // ✅ Reduced
                                    Text(
                                      OwnerStrings.welcomeOwner,
                                      style: GoogleFonts.cairo(
                                        fontSize: ResponsiveHelper.fontSize(
                                          18,
                                        ), // ✅ Reduced from 20
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold,
                                        height: 1.2,
                                      ),
                                      textDirection: TextDirection.rtl,
                                    ),
                                    SizedBox(
                                      height: ResponsiveHelper.height(2),
                                    ), // ✅ Reduced
                                    Text(
                                      'إدارة عقاراتك بسهولة',
                                      style: GoogleFonts.tajawal(
                                        fontSize: ResponsiveHelper.fontSize(
                                          11,
                                        ), // ✅ Reduced from 12
                                        color: AppColors.white.withOpacity(0.8),
                                      ),
                                      textDirection: TextDirection.rtl,
                                    ),
                                  ],
                                ),
                              ),
                              // Notification
                              Container(
                                width: ResponsiveHelper.width(42),
                                height: ResponsiveHelper.width(42),
                                decoration: BoxDecoration(
                                  color: AppColors.white.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(
                                    ResponsiveHelper.radius(12),
                                  ),
                                  border: Border.all(
                                    color: AppColors.white.withOpacity(0.2),
                                    width: 1,
                                  ),
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(
                                    Icons.notifications_outlined,
                                    color: AppColors.white,
                                    size: ResponsiveHelper.width(22),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: ResponsiveHelper.height(12),
                          ), // ✅ Reduced from 16
                          // Stats Row
                          _buildStatsRow(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // My Apartments Section
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  ResponsiveHelper.width(16),
                  ResponsiveHelper.height(20),
                  ResponsiveHelper.width(16),
                  ResponsiveHelper.height(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textDirection: TextDirection.rtl,
                  children: [
                    Text(
                      OwnerStrings.myApartments,
                      style: GoogleFonts.cairo(
                        fontSize: ResponsiveHelper.fontSize(18),
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveHelper.width(12),
                        vertical: ResponsiveHelper.height(6),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(
                          ResponsiveHelper.radius(20),
                        ),
                      ),
                      child: Text(
                        '12 عقار',
                        style: GoogleFonts.cairo(
                          fontSize: ResponsiveHelper.fontSize(12),
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Owner Apartments List
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.width(16),
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return OwnerApartmentCard(
                    onTap: () {
                      context.push(RouteNames.apartmentDetails);
                    },
                    onEdit: () {
                      // TODO: Navigate to edit apartment
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'تعديل العقار',
                            style: GoogleFonts.tajawal(),
                            textDirection: TextDirection.rtl,
                          ),
                          backgroundColor: AppColors.primary,
                        ),
                      );
                    },
                    onDelete: () {
                      // TODO: Show delete confirmation
                      _showDeleteDialog(context);
                    },
                  );
                }, childCount: 12),
              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: ResponsiveHelper.height(100)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        _buildStatCard(
          icon: Icons.apartment_rounded,
          label: 'عقاراتي',
          value: '12',
          color: AppColors.white,
        ),
        SizedBox(width: ResponsiveHelper.width(10)), // ✅ Reduced from 12
        _buildStatCard(
          icon: Icons.visibility_rounded,
          label: 'المشاهدات',
          value: '2.4K',
          color: AppColors.white.withOpacity(0.9),
        ),
        SizedBox(width: ResponsiveHelper.width(10)), // ✅ Reduced from 12
        _buildStatCard(
          icon: Icons.favorite_rounded,
          label: 'الإعجابات',
          value: '856',
          color: AppColors.white.withOpacity(0.9),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.width(10), // ✅ Reduced from 12
          vertical: ResponsiveHelper.height(8), // ✅ Reduced from 10
        ),
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
          border: Border.all(color: AppColors.white.withOpacity(0.2), width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // ✅ Added to prevent overflow
          children: [
            Icon(
              icon,
              color: color,
              size: ResponsiveHelper.width(18), // ✅ Reduced from 20
            ),
            SizedBox(height: ResponsiveHelper.height(3)), // ✅ Reduced from 4
            Text(
              value,
              style: GoogleFonts.cairo(
                fontSize: ResponsiveHelper.fontSize(15), // ✅ Reduced from 16
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.tajawal(
                fontSize: ResponsiveHelper.fontSize(9), // ✅ Reduced from 10
                color: color.withOpacity(0.8),
              ),
              textDirection: TextDirection.rtl,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
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
          title: Text(
            'حذف العقار',
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(18),
              fontWeight: FontWeight.bold,
            ),
            textDirection: TextDirection.rtl,
          ),
          content: Text(
            'هل أنت متأكد من حذف هذا العقار؟',
            style: GoogleFonts.tajawal(fontSize: ResponsiveHelper.fontSize(14)),
            textDirection: TextDirection.rtl,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'إلغاء',
                style: GoogleFonts.tajawal(color: Colors.grey.shade600),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'تم حذف العقار بنجاح',
                      style: GoogleFonts.tajawal(),
                      textDirection: TextDirection.rtl,
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
                style: GoogleFonts.tajawal(color: AppColors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
