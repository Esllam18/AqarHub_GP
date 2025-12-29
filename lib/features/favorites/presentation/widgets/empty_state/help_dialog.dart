import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'help_step_item.dart';
import 'help_feature_tile.dart';

class HelpDialog extends StatelessWidget {
  const HelpDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: CustomScrollView(
          slivers: [_buildAppBar(context), _buildContent(context)],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
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
          child: SafeArea(child: _buildAppBarContent()),
        ),
      ),
    );
  }

  Widget _buildAppBarContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: ResponsiveHelper.height(40)),
        _buildAnimatedIcon(),
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
    );
  }

  Widget _buildAnimatedIcon() {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: 1.0),
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
    );
  }

  Widget _buildContent(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(ResponsiveHelper.width(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ResponsiveHelper.height(20)),
            _buildSteps(),
            SizedBox(height: ResponsiveHelper.height(24)),
            _buildProTip(),
            SizedBox(height: ResponsiveHelper.height(24)),
            _buildAdditionalFeatures(),
            SizedBox(height: ResponsiveHelper.height(40)),
            _buildActionButton(context),
            SizedBox(height: ResponsiveHelper.height(40)),
          ],
        ),
      ),
    );
  }

  Widget _buildSteps() {
    return Column(
      children: [
        HelpStepItem(
          number: '1',
          title: 'تصفح العقارات',
          description: 'ابحث عن العقارات المتاحة في التطبيق',
          icon: Icons.search_rounded,
          color: AppColors.primary,
        ),
        SizedBox(height: ResponsiveHelper.height(20)),
        HelpStepItem(
          number: '2',
          title: 'اضغط على القلب',
          description: 'اضغط على أيقونة القلب ♥ في أي عقار يعجبك',
          icon: Icons.favorite_rounded,
          color: AppColors.error,
        ),
        SizedBox(height: ResponsiveHelper.height(20)),
        HelpStepItem(
          number: '3',
          title: 'تمت الإضافة!',
          description: 'سيظهر العقار هنا في قائمة المفضلة',
          icon: Icons.check_circle_rounded,
          color: AppColors.success,
        ),
      ],
    );
  }

  Widget _buildProTip() {
    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.width(20)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.1),
            AppColors.secondary.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
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
                padding: EdgeInsets.all(ResponsiveHelper.width(8)),
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
    );
  }

  Widget _buildAdditionalFeatures() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        HelpFeatureTile(
          icon: Icons.filter_list_rounded,
          title: 'فلترة وترتيب',
          description: 'رتب المفضلة حسب السعر أو التقييم أو التاريخ',
          color: AppColors.primary,
        ),
        SizedBox(height: ResponsiveHelper.height(12)),
        HelpFeatureTile(
          icon: Icons.compare_rounded,
          title: 'مقارنة سهلة',
          description: 'قارن بين العقارات المفضلة بسهولة',
          color: AppColors.secondary,
        ),
        SizedBox(height: ResponsiveHelper.height(12)),
        HelpFeatureTile(
          icon: Icons.notifications_active_rounded,
          title: 'تنبيهات فورية',
          description: 'احصل على إشعارات عند تغير أسعار المفضلة',
          color: AppColors.success,
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        context.go('/');
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.height(16)),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
          ),
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(14)),
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
    );
  }
}
