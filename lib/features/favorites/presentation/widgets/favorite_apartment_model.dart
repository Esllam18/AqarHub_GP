import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:go_router/go_router.dart';

class FavoritesEmptyState extends StatelessWidget {
  const FavoritesEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(ResponsiveHelper.width(24)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated Heart Icon
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 800),
                curve: Curves.elasticOut,
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Container(
                      width: ResponsiveHelper.width(120),
                      height: ResponsiveHelper.width(120),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.error.withOpacity(0.1),
                            AppColors.error.withOpacity(0.05),
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.favorite_border_rounded,
                        size: ResponsiveHelper.width(60),
                        color: AppColors.error.withOpacity(0.6),
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: ResponsiveHelper.height(26)),

              // Title
              Text(
                'لا توجد مفضلة بعد',
                style: GoogleFonts.cairo(
                  fontSize: ResponsiveHelper.fontSize(24),
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textDirection: TextDirection.rtl,
              ),

              SizedBox(height: ResponsiveHelper.height(10)),

              // Description
              Text(
                'ابدأ بإضافة العقارات المفضلة لديك\nلتتمكن من الوصول إليها بسهولة',
                textAlign: TextAlign.center,
                style: GoogleFonts.tajawal(
                  fontSize: ResponsiveHelper.fontSize(15),
                  color: Colors.grey.shade600,
                  height: 1.6,
                ),
                textDirection: TextDirection.rtl,
              ),

              SizedBox(height: ResponsiveHelper.height(30)),

              // Features List
              _buildFeatureItem(
                icon: Icons.favorite_rounded,
                title: 'احفظ ما يعجبك',
                description: 'أضف العقارات المفضلة بنقرة واحدة',
                color: AppColors.error,
              ),

              SizedBox(height: ResponsiveHelper.height(12)),

              _buildFeatureItem(
                icon: Icons.access_time_rounded,
                title: 'وصول سريع',
                description: 'تصفح مفضلاتك في أي وقت',
                color: AppColors.primary,
              ),

              SizedBox(height: ResponsiveHelper.height(12)),

              _buildFeatureItem(
                icon: Icons.compare_rounded,
                title: 'قارن بسهولة',
                description: 'قارن بين العقارات المفضلة',
                color: AppColors.success,
              ),

              SizedBox(height: ResponsiveHelper.height(30)),

              // Action Button
              GestureDetector(
                onTap: () {
                  // Navigate to home/explore
                  context.go('/');
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveHelper.width(40),
                    vertical: ResponsiveHelper.height(16),
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.secondary],
                    ),
                    borderRadius: BorderRadius.circular(
                      ResponsiveHelper.radius(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    textDirection: TextDirection.rtl,
                    children: [
                      Icon(
                        Icons.search_rounded,
                        color: AppColors.white,
                        size: ResponsiveHelper.width(22),
                      ),
                      SizedBox(width: ResponsiveHelper.width(10)),
                      Text(
                        'تصفح العقارات',
                        style: GoogleFonts.cairo(
                          fontSize: ResponsiveHelper.fontSize(16),
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: ResponsiveHelper.height(20)),

              // Secondary Action
              TextButton.icon(
                onPressed: () {
                  // Show help or tips
                  _showHelpDialog(context);
                },
                icon: Icon(
                  Icons.help_outline_rounded,
                  color: AppColors.primary,
                  size: ResponsiveHelper.width(18),
                ),
                label: Text(
                  'كيف أضيف عقار للمفضلة؟',
                  style: GoogleFonts.tajawal(
                    fontSize: ResponsiveHelper.fontSize(13),
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.width(16)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(14)),
        border: Border.all(color: color.withOpacity(0.2), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Container(
            width: ResponsiveHelper.width(50),
            height: ResponsiveHelper.width(50),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
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
                  description,
                  style: GoogleFonts.tajawal(
                    fontSize: ResponsiveHelper.fontSize(12),
                    color: Colors.grey.shade600,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: AppColors.background,
            body: CustomScrollView(
              slivers: [
                // App Bar
                SliverAppBar(
                  expandedHeight: ResponsiveHelper.height(220),
                  floating: false,
                  pinned: true,
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                  leading: IconButton(
                    icon: Icon(
                      Icons.close_rounded,
                      color: AppColors.white,
                      size: ResponsiveHelper.width(24),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: ResponsiveHelper.height(40)),
                            // Animated Icon
                            TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0.0, end: 1.0),
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.elasticOut,
                              builder: (context, value, child) {
                                return Transform.scale(
                                  scale: value,
                                  child: Container(
                                    width: ResponsiveHelper.width(90),
                                    height: ResponsiveHelper.width(90),
                                    decoration: BoxDecoration(
                                      color: AppColors.white.withOpacity(0.2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.lightbulb_rounded,
                                      color: AppColors.white,
                                      size: ResponsiveHelper.width(45),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: ResponsiveHelper.height(16)),
                            Text(
                              'كيفية استخدام المفضلة',
                              style: GoogleFonts.cairo(
                                fontSize: ResponsiveHelper.fontSize(26),
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                            SizedBox(height: ResponsiveHelper.height(8)),
                            Text(
                              'اتبع الخطوات التالية لإضافة عقار للمفضلة',
                              style: GoogleFonts.tajawal(
                                fontSize: ResponsiveHelper.fontSize(14),
                                color: AppColors.white.withOpacity(0.9),
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Content
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(ResponsiveHelper.width(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: ResponsiveHelper.height(20)),

                        // Step 1
                        _buildEnhancedHelpStep(
                          number: '1',
                          title: 'تصفح العقارات',
                          description: 'ابحث عن العقارات المتاحة في التطبيق',
                          icon: Icons.search_rounded,
                          color: AppColors.primary,
                        ),

                        SizedBox(height: ResponsiveHelper.height(20)),

                        // Step 2
                        _buildEnhancedHelpStep(
                          number: '2',
                          title: 'اضغط على القلب',
                          description:
                              'اضغط على أيقونة القلب ♥ في أي عقار يعجبك',
                          icon: Icons.favorite_rounded,
                          color: AppColors.error,
                        ),

                        SizedBox(height: ResponsiveHelper.height(20)),

                        // Step 3
                        _buildEnhancedHelpStep(
                          number: '3',
                          title: 'تمت الإضافة!',
                          description: 'سيظهر العقار هنا في قائمة المفضلة',
                          icon: Icons.check_circle_rounded,
                          color: AppColors.success,
                        ),

                        SizedBox(height: ResponsiveHelper.height(24)),

                        // Pro Tip Box
                        Container(
                          padding: EdgeInsets.all(ResponsiveHelper.width(20)),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primary.withOpacity(0.1),
                                AppColors.secondary.withOpacity(0.05),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(
                              ResponsiveHelper.radius(16),
                            ),
                            border: Border.all(
                              color: AppColors.primary.withOpacity(0.2),
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                textDirection: TextDirection.rtl,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(
                                      ResponsiveHelper.width(8),
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(
                                        ResponsiveHelper.radius(10),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.tips_and_updates_rounded,
                                      color: AppColors.primary,
                                      size: ResponsiveHelper.width(22),
                                    ),
                                  ),
                                  SizedBox(width: ResponsiveHelper.width(12)),
                                  Text(
                                    'نصيحة احترافية',
                                    style: GoogleFonts.cairo(
                                      fontSize: ResponsiveHelper.fontSize(16),
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                    textDirection: TextDirection.rtl,
                                  ),
                                ],
                              ),
                              SizedBox(height: ResponsiveHelper.height(12)),
                              Text(
                                'يمكنك إزالة أي عقار من المفضلة بالضغط على القلب مرة أخرى، أو من خلال صفحة المفضلة مباشرة.',
                                style: GoogleFonts.tajawal(
                                  fontSize: ResponsiveHelper.fontSize(14),
                                  color: Colors.grey.shade700,
                                  height: 1.6,
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: ResponsiveHelper.height(24)),

                        // Additional Tips
                        Text(
                          'مزايا إضافية',
                          style: GoogleFonts.cairo(
                            fontSize: ResponsiveHelper.fontSize(18),
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textDirection: TextDirection.rtl,
                        ),

                        SizedBox(height: ResponsiveHelper.height(16)),

                        _buildFeatureTile(
                          icon: Icons.filter_list_rounded,
                          title: 'فلترة وترتيب',
                          description:
                              'رتب المفضلة حسب السعر أو التقييم أو التاريخ',
                          color: AppColors.primary,
                        ),

                        SizedBox(height: ResponsiveHelper.height(12)),

                        _buildFeatureTile(
                          icon: Icons.compare_rounded,
                          title: 'مقارنة سهلة',
                          description: 'قارن بين العقارات المفضلة بسهولة',
                          color: AppColors.secondary,
                        ),

                        SizedBox(height: ResponsiveHelper.height(12)),

                        _buildFeatureTile(
                          icon: Icons.notifications_active_rounded,
                          title: 'تنبيهات فورية',
                          description:
                              'احصل على إشعارات عند تغير أسعار المفضلة',
                          color: AppColors.success,
                        ),

                        SizedBox(height: ResponsiveHelper.height(40)),

                        // Action Button
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            context.go('/');
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              vertical: ResponsiveHelper.height(16),
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.primary,
                                  AppColors.secondary,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(
                                ResponsiveHelper.radius(14),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.4),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.explore_rounded,
                                  color: AppColors.white,
                                  size: ResponsiveHelper.width(22),
                                ),
                                SizedBox(width: ResponsiveHelper.width(10)),
                                Text(
                                  'ابدأ الاستكشاف الآن',
                                  style: GoogleFonts.cairo(
                                    fontSize: ResponsiveHelper.fontSize(16),
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: ResponsiveHelper.height(40)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Enhanced Help Step Widget
  Widget _buildEnhancedHelpStep({
    required String number,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.width(18)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          // Number Badge
          Container(
            width: ResponsiveHelper.width(50),
            height: ResponsiveHelper.width(50),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [color, color.withOpacity(0.7)]),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                number,
                style: GoogleFonts.cairo(
                  fontSize: ResponsiveHelper.fontSize(20),
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
            ),
          ),

          SizedBox(width: ResponsiveHelper.width(16)),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Icon(icon, color: color, size: ResponsiveHelper.width(18)),
                    SizedBox(width: ResponsiveHelper.width(8)),
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.cairo(
                          fontSize: ResponsiveHelper.fontSize(16),
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ResponsiveHelper.height(6)),
                Text(
                  description,
                  style: GoogleFonts.tajawal(
                    fontSize: ResponsiveHelper.fontSize(13),
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Feature Tile Widget
  Widget _buildFeatureTile({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.width(16)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Container(
            width: ResponsiveHelper.width(44),
            height: ResponsiveHelper.width(44),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(ResponsiveHelper.radius(10)),
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
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: ResponsiveHelper.height(3)),
                Text(
                  description,
                  style: GoogleFonts.tajawal(
                    fontSize: ResponsiveHelper.fontSize(12),
                    color: Colors.grey.shade600,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
