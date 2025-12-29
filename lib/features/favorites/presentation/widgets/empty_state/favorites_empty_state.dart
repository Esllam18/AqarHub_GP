import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'empty_feature_item.dart';
import 'help_dialog.dart';

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
              _buildAnimatedIcon(),
              SizedBox(height: ResponsiveHelper.height(26)),
              _buildTitle(),
              SizedBox(height: ResponsiveHelper.height(10)),
              _buildDescription(),
              SizedBox(height: ResponsiveHelper.height(30)),
              _buildFeaturesList(),
              SizedBox(height: ResponsiveHelper.height(30)),
              _buildExploreButton(context),
              SizedBox(height: ResponsiveHelper.height(20)),
              _buildHelpButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedIcon() {
    return TweenAnimationBuilder<double>(
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
    );
  }

  Widget _buildTitle() {
    return Text(
      'لا توجد مفضلة بعد',
      style: GoogleFonts.cairo(
        fontSize: ResponsiveHelper.fontSize(24),
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      textDirection: TextDirection.rtl,
    );
  }

  Widget _buildDescription() {
    return Text(
      'ابدأ بإضافة العقارات المفضلة لديك\nلتتمكن من الوصول إليها بسهولة',
      textAlign: TextAlign.center,
      style: GoogleFonts.tajawal(
        fontSize: ResponsiveHelper.fontSize(15),
        color: Colors.grey.shade600,
        height: 1.6,
      ),
      textDirection: TextDirection.rtl,
    );
  }

  Widget _buildFeaturesList() {
    return Column(
      children: [
        EmptyFeatureItem(
          icon: Icons.favorite_rounded,
          title: 'احفظ ما يعجبك',
          description: 'أضف العقارات المفضلة بنقرة واحدة',
          color: AppColors.error,
        ),
        SizedBox(height: ResponsiveHelper.height(12)),
        EmptyFeatureItem(
          icon: Icons.access_time_rounded,
          title: 'وصول سريع',
          description: 'تصفح مفضلاتك في أي وقت',
          color: AppColors.primary,
        ),
        SizedBox(height: ResponsiveHelper.height(12)),
        EmptyFeatureItem(
          icon: Icons.compare_rounded,
          title: 'قارن بسهولة',
          description: 'قارن بين العقارات المفضلة',
          color: AppColors.success,
        ),
      ],
    );
  }

  Widget _buildExploreButton(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go('/'),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.width(40),
          vertical: ResponsiveHelper.height(16),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
          ),
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(30)),
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
    );
  }

  Widget _buildHelpButton(BuildContext context) {
    return TextButton.icon(
      onPressed: () => _showHelpDialog(context),
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
    );
  }

  void _showHelpDialog(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => const HelpDialog(),
      ),
    );
  }
}
