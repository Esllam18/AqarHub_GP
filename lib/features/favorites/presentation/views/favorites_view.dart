import 'package:aqar_hub_gp/features/favorites/presentation/widgets/favorite_apartment_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:go_router/go_router.dart';
import '../../models/favorite_apartment_model.dart';
import '../widgets/favorite_apartment_card.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // ✅ Sample favorites for demonstration
  List<FavoriteApartmentModel> _favorites = [
    FavoriteApartmentModel(
      id: '1',
      title: 'شقة استوديو فاخرة في موقع مميز',
      location: 'مدينة نصر، القاهرة',
      image:
          'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800',
      price: 3500,
      bedrooms: 2,
      bathrooms: 1,
      area: 80,
      isVerified: true,
      rating: 4.8,
      addedDate: DateTime.now().subtract(const Duration(days: 2)),
    ),
    FavoriteApartmentModel(
      id: '2',
      title: 'شقة عصرية بإطلالة رائعة',
      location: 'التجمع الخامس، القاهرة',
      image:
          'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800',
      price: 5000,
      bedrooms: 3,
      bathrooms: 2,
      area: 120,
      isVerified: true,
      rating: 4.9,
      addedDate: DateTime.now().subtract(const Duration(days: 5)),
    ),
    FavoriteApartmentModel(
      id: '3',
      title: 'شقة مفروشة بالكامل',
      location: 'الشيخ زايد، الجيزة',
      image: 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=800',
      price: 4200,
      bedrooms: 2,
      bathrooms: 2,
      area: 95,
      isVerified: false,
      rating: 4.6,
      addedDate: DateTime.now().subtract(const Duration(days: 7)),
    ),
    FavoriteApartmentModel(
      id: '4',
      title: 'بنتهاوس فاخر مع سطح خاص',
      location: 'المعادي، القاهرة',
      image:
          'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=800',
      price: 8000,
      bedrooms: 4,
      bathrooms: 3,
      area: 200,
      isVerified: true,
      rating: 5.0,
      addedDate: DateTime.now().subtract(const Duration(days: 10)),
    ),
  ];

  // ✅ Toggle this to test empty state
  bool _showEmptyState = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _removeFavorite(String id) {
    setState(() {
      _favorites.removeWhere((apartment) => apartment.id == id);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          textDirection: TextDirection.rtl,
          children: [
            Icon(Icons.check_circle_rounded, color: AppColors.white),
            SizedBox(width: ResponsiveHelper.width(10)),
            Text(
              'تم الإزالة من المفضلة',
              style: GoogleFonts.tajawal(),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        action: SnackBarAction(
          label: 'تراجع',
          textColor: AppColors.white,
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: _showEmptyState || _favorites.isEmpty
            ? const FavoritesEmptyState()
            : CustomScrollView(
                slivers: [
                  // Premium App Bar
                  SliverAppBar(
                    expandedHeight: ResponsiveHelper.height(180),
                    floating: false,
                    pinned: true,
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
                            padding: EdgeInsets.all(ResponsiveHelper.width(20)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'مفضلتي',
                                          style: GoogleFonts.cairo(
                                            fontSize: ResponsiveHelper.fontSize(
                                              28,
                                            ),
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.white,
                                          ),
                                          textDirection: TextDirection.rtl,
                                        ),
                                        SizedBox(
                                          height: ResponsiveHelper.height(4),
                                        ),
                                        Text(
                                          '${_favorites.length} عقار محفوظ',
                                          style: GoogleFonts.tajawal(
                                            fontSize: ResponsiveHelper.fontSize(
                                              14,
                                            ),
                                            color: AppColors.white.withOpacity(
                                              0.9,
                                            ),
                                          ),
                                          textDirection: TextDirection.rtl,
                                        ),
                                      ],
                                    ),
                                    // Action Buttons
                                    Row(
                                      children: [
                                        _buildHeaderButton(
                                          icon: Icons.filter_list_rounded,
                                          onTap: () => _showFilterSheet(),
                                        ),
                                        SizedBox(
                                          width: ResponsiveHelper.width(8),
                                        ),
                                        _buildHeaderButton(
                                          icon: Icons.delete_sweep_rounded,
                                          onTap: () => _showClearAllDialog(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: ResponsiveHelper.height(16)),
                                // Stats Row
                                _buildStatsRow(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Filter Tabs
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverAppBarDelegate(
                      TabBar(
                        controller: _tabController,
                        labelColor: AppColors.primary,
                        unselectedLabelColor: Colors.grey.shade600,
                        indicatorColor: AppColors.primary,
                        indicatorWeight: 3,
                        indicatorSize: TabBarIndicatorSize.label,
                        labelStyle: GoogleFonts.cairo(
                          fontSize: ResponsiveHelper.fontSize(14),
                          fontWeight: FontWeight.bold,
                        ),
                        unselectedLabelStyle: GoogleFonts.tajawal(
                          fontSize: ResponsiveHelper.fontSize(14),
                        ),
                        tabs: const [
                          Tab(text: 'الكل'),
                          Tab(text: 'موثقة'),
                          Tab(text: 'حديثة'),
                        ],
                      ),
                    ),
                  ),

                  // Favorites List
                  SliverPadding(
                    padding: EdgeInsets.all(ResponsiveHelper.width(16)),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final apartment = _favorites[index];
                        return FavoriteApartmentCard(
                          apartment: apartment,
                          onTap: () {
                            context.push('/apartment-details/${apartment.id}');
                          },
                          onRemove: () => _removeFavorite(apartment.id),
                        );
                      }, childCount: _favorites.length),
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: SizedBox(height: ResponsiveHelper.height(20)),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildHeaderButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: ResponsiveHelper.width(40),
        height: ResponsiveHelper.width(40),
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
          border: Border.all(color: AppColors.white.withOpacity(0.3), width: 1),
        ),
        child: Icon(
          icon,
          color: AppColors.white,
          size: ResponsiveHelper.width(20),
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        _buildStatItem(
          icon: Icons.verified_rounded,
          label: 'موثقة',
          value: _favorites.where((apt) => apt.isVerified).length.toString(),
        ),
        SizedBox(width: ResponsiveHelper.width(20)),
        _buildStatItem(
          icon: Icons.star_rounded,
          label: 'تقييم عالي',
          value: _favorites.where((apt) => apt.rating >= 4.5).length.toString(),
        ),
        SizedBox(width: ResponsiveHelper.width(20)),
        _buildStatItem(
          icon: Icons.trending_up_rounded,
          label: 'هذا الأسبوع',
          value: _favorites
              .where(
                (apt) => apt.addedDate.isAfter(
                  DateTime.now().subtract(const Duration(days: 7)),
                ),
              )
              .length
              .toString(),
        ),
      ],
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, color: AppColors.white, size: ResponsiveHelper.width(16)),
        SizedBox(width: ResponsiveHelper.width(6)),
        Text(
          value,
          style: GoogleFonts.cairo(
            fontSize: ResponsiveHelper.fontSize(16),
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        SizedBox(width: ResponsiveHelper.width(4)),
        Text(
          label,
          style: GoogleFonts.tajawal(
            fontSize: ResponsiveHelper.fontSize(11),
            color: AppColors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  // ✅ IMPROVED FILTER BOTTOM SHEET
  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(ResponsiveHelper.radius(28)),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle Bar
            Container(
              margin: EdgeInsets.only(top: ResponsiveHelper.height(12)),
              width: ResponsiveHelper.width(50),
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(3),
              ),
            ),

            SizedBox(height: ResponsiveHelper.height(20)),

            // Header with Icon
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.width(20),
              ),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Container(
                    padding: EdgeInsets.all(ResponsiveHelper.width(10)),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary.withOpacity(0.2),
                          AppColors.secondary.withOpacity(0.2),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(
                        ResponsiveHelper.radius(12),
                      ),
                    ),
                    child: Icon(
                      Icons.filter_list_rounded,
                      color: AppColors.primary,
                      size: ResponsiveHelper.width(24),
                    ),
                  ),
                  SizedBox(width: ResponsiveHelper.width(12)),
                  Text(
                    'ترتيب وفلترة المفضلة',
                    style: GoogleFonts.cairo(
                      fontSize: ResponsiveHelper.fontSize(20),
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),

            SizedBox(height: ResponsiveHelper.height(24)),

            // Filter Options
            _buildFilterOption(
              icon: Icons.access_time_rounded,
              title: 'الأحدث أولاً',
              subtitle: 'حسب تاريخ الإضافة',
              color: AppColors.primary,
              onTap: () {
                Navigator.pop(context);
                // TODO: Sort by date
              },
            ),

            _buildFilterOption(
              icon: Icons.arrow_downward_rounded,
              title: 'السعر الأقل',
              subtitle: 'من الأرخص إلى الأغلى',
              color: AppColors.success,
              onTap: () {
                Navigator.pop(context);
                // TODO: Sort by price low to high
              },
            ),

            _buildFilterOption(
              icon: Icons.arrow_upward_rounded,
              title: 'السعر الأعلى',
              subtitle: 'من الأغلى إلى الأرخص',
              color: AppColors.error,
              onTap: () {
                Navigator.pop(context);
                // TODO: Sort by price high to low
              },
            ),

            _buildFilterOption(
              icon: Icons.star_rounded,
              title: 'التقييم الأعلى',
              subtitle: 'الأكثر تقييماً أولاً',
              color: Colors.amber,
              onTap: () {
                Navigator.pop(context);
                // TODO: Sort by rating
              },
            ),

            _buildFilterOption(
              icon: Icons.verified_rounded,
              title: 'الموثقة فقط',
              subtitle: 'عرض العقارات الموثقة',
              color: AppColors.success,
              onTap: () {
                Navigator.pop(context);
                // TODO: Filter verified only
              },
            ),

            SizedBox(height: ResponsiveHelper.height(20)),

            // Reset Button
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.width(20),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Reset filters
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: ResponsiveHelper.height(14),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300, width: 1.5),
                    borderRadius: BorderRadius.circular(
                      ResponsiveHelper.radius(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    textDirection: TextDirection.rtl,
                    children: [
                      Icon(
                        Icons.refresh_rounded,
                        color: Colors.grey.shade700,
                        size: ResponsiveHelper.width(20),
                      ),
                      SizedBox(width: ResponsiveHelper.width(8)),
                      Text(
                        'إعادة تعيين الفلاتر',
                        style: GoogleFonts.tajawal(
                          fontSize: ResponsiveHelper.fontSize(14),
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: ResponsiveHelper.height(30)),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.width(20),
          vertical: ResponsiveHelper.height(6),
        ),
        padding: EdgeInsets.all(ResponsiveHelper.width(16)),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(14)),
          border: Border.all(color: color.withOpacity(0.2), width: 1),
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Container(
              width: ResponsiveHelper.width(50),
              height: ResponsiveHelper.width(50),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(
                  ResponsiveHelper.radius(12),
                ),
              ),
              child: Icon(icon, color: color, size: ResponsiveHelper.width(24)),
            ),
            SizedBox(width: ResponsiveHelper.width(14)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.cairo(
                      fontSize: ResponsiveHelper.fontSize(15),
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(height: ResponsiveHelper.height(3)),
                  Text(
                    subtitle,
                    style: GoogleFonts.tajawal(
                      fontSize: ResponsiveHelper.fontSize(12),
                      color: Colors.grey.shade600,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_left_rounded,
              color: color,
              size: ResponsiveHelper.width(20),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ IMPROVED DELETE DIALOG
  void _showClearAllDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ResponsiveHelper.radius(24)),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(ResponsiveHelper.radius(24)),
            ),
            padding: EdgeInsets.all(ResponsiveHelper.width(24)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Animated Icon
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.elasticOut,
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: Container(
                        width: ResponsiveHelper.width(80),
                        height: ResponsiveHelper.width(80),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.error.withOpacity(0.2),
                              AppColors.error.withOpacity(0.1),
                            ],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.delete_sweep_rounded,
                          color: AppColors.error,
                          size: ResponsiveHelper.width(40),
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: ResponsiveHelper.height(20)),

                // Title
                Text(
                  'مسح جميع المفضلة؟',
                  style: GoogleFonts.cairo(
                    fontSize: ResponsiveHelper.fontSize(22),
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textDirection: TextDirection.rtl,
                ),

                SizedBox(height: ResponsiveHelper.height(12)),

                // Description
                Text(
                  'سيتم حذف جميع العقارات (${_favorites.length} عقار) من المفضلة بشكل نهائي.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.tajawal(
                    fontSize: ResponsiveHelper.fontSize(14),
                    color: Colors.grey.shade600,
                    height: 1.6,
                  ),
                  textDirection: TextDirection.rtl,
                ),

                SizedBox(height: ResponsiveHelper.height(8)),

                // Warning Box
                Container(
                  padding: EdgeInsets.all(ResponsiveHelper.width(12)),
                  decoration: BoxDecoration(
                    color: AppColors.error.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(
                      ResponsiveHelper.radius(12),
                    ),
                    border: Border.all(
                      color: AppColors.error.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Icon(
                        Icons.warning_rounded,
                        color: AppColors.error,
                        size: ResponsiveHelper.width(18),
                      ),
                      SizedBox(width: ResponsiveHelper.width(8)),
                      Expanded(
                        child: Text(
                          'لا يمكن التراجع عن هذا الإجراء',
                          style: GoogleFonts.tajawal(
                            fontSize: ResponsiveHelper.fontSize(12),
                            color: AppColors.error,
                            fontWeight: FontWeight.w600,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: ResponsiveHelper.height(24)),

                // Action Buttons
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    // Cancel Button
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: ResponsiveHelper.height(14),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(
                              ResponsiveHelper.radius(12),
                            ),
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.close_rounded,
                                color: Colors.grey.shade700,
                                size: ResponsiveHelper.width(18),
                              ),
                              SizedBox(width: ResponsiveHelper.width(6)),
                              Text(
                                'إلغاء',
                                style: GoogleFonts.tajawal(
                                  fontSize: ResponsiveHelper.fontSize(14),
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: ResponsiveHelper.width(12)),

                    // Delete Button
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _favorites.clear();
                          });
                          Navigator.pop(context);

                          // Show success message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                textDirection: TextDirection.rtl,
                                children: [
                                  Icon(
                                    Icons.check_circle_rounded,
                                    color: AppColors.white,
                                  ),
                                  SizedBox(width: ResponsiveHelper.width(10)),
                                  Text(
                                    'تم مسح جميع المفضلة بنجاح',
                                    style: GoogleFonts.tajawal(),
                                    textDirection: TextDirection.rtl,
                                  ),
                                ],
                              ),
                              backgroundColor: AppColors.success,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: ResponsiveHelper.height(14),
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.error,
                                AppColors.error.withOpacity(0.8),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(
                              ResponsiveHelper.radius(12),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.error.withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.delete_rounded,
                                color: AppColors.white,
                                size: ResponsiveHelper.width(18),
                              ),
                              SizedBox(width: ResponsiveHelper.width(6)),
                              Text(
                                'مسح الكل',
                                style: GoogleFonts.tajawal(
                                  fontSize: ResponsiveHelper.fontSize(14),
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ✅ Tab Bar Delegate (OUTSIDE the State class)
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: AppColors.white, child: _tabBar);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
