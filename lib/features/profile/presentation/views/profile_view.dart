import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:aqar_hub_gp/core/router/route_names.dart';
import '../widgets/profile_section_header.dart';
import '../widgets/profile_menu_item.dart';

class ProfileView extends StatelessWidget {
  final bool isOwner; // Pass from main layout

  const ProfileView({
    super.key,
    this.isOwner = false, // Default to seeker
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: CustomScrollView(
          slivers: [
            // App Bar with Profile Header
            SliverAppBar(
              expandedHeight: ResponsiveHelper.height(200),
              floating: false,
              pinned: true,
              backgroundColor: AppColors.primary,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        AppColors.primary,
                        AppColors.primary.withOpacity(0.8),
                      ],
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: ResponsiveHelper.height(20)),
                        // Profile Avatar
                        Container(
                          width: ResponsiveHelper.width(90),
                          height: ResponsiveHelper.width(90),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                            image: const DecorationImage(
                              image: NetworkImage(
                                'https://i.pravatar.cc/150?img=12',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: ResponsiveHelper.height(12)),
                        // User Name
                        Text(
                          'أحمد محمد علي',
                          style: GoogleFonts.cairo(
                            fontSize: ResponsiveHelper.fontSize(20),
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: ResponsiveHelper.height(4)),
                        // User Role Badge
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveHelper.width(12),
                            vertical: ResponsiveHelper.height(6),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(
                              ResponsiveHelper.radius(20),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isOwner
                                    ? Icons.business_rounded
                                    : Icons.person_rounded,
                                color: Colors.white,
                                size: ResponsiveHelper.width(16),
                              ),
                              SizedBox(width: ResponsiveHelper.width(6)),
                              Text(
                                isOwner ? 'مالك عقار' : 'باحث عن سكن',
                                style: GoogleFonts.tajawal(
                                  fontSize: ResponsiveHelper.fontSize(13),
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Profile Content
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(ResponsiveHelper.width(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: ResponsiveHelper.height(8)),

                    // Account Section
                    const ProfileSectionHeader(title: 'الحساب'),
                    SizedBox(height: ResponsiveHelper.height(12)),
                    _buildMenuCard(context, [
                      ProfileMenuItem(
                        icon: Icons.edit_rounded,
                        title: 'تعديل الملف الشخصي',
                        onTap: () => context.push('/${RouteNames.editProfile}'),
                      ),
                      if (isOwner)
                        ProfileMenuItem(
                          icon: Icons.apartment_rounded,
                          title: 'عقاراتي',
                          trailing: _buildBadge('5'),
                          onTap: () =>
                              context.push('/${RouteNames.myProperties}'),
                        ),
                      ProfileMenuItem(
                        icon: Icons.favorite_rounded,
                        title: 'المفضلة',
                        trailing: _buildBadge('12'),
                        onTap: () => context.push('/${RouteNames.favorites}'),
                      ),
                      ProfileMenuItem(
                        icon: Icons.history_rounded,
                        title: 'سجل المدفوعات',
                        onTap: () =>
                            context.push('/${RouteNames.paymentHistory}'),
                      ),
                    ]),

                    SizedBox(height: ResponsiveHelper.height(24)),

                    // Settings Section
                    const ProfileSectionHeader(title: 'الإعدادات'),
                    SizedBox(height: ResponsiveHelper.height(12)),
                    _buildMenuCard(context, [
                      ProfileMenuItem(
                        icon: Icons.settings_rounded,
                        title: 'الإعدادات',
                        onTap: () => context.push('/${RouteNames.settings}'),
                      ),
                      ProfileMenuItem(
                        icon: Icons.notifications_rounded,
                        title: 'الإشعارات',
                        trailing: _buildBadge('3'),
                        onTap: () =>
                            context.push('/${RouteNames.notifications}'),
                      ),
                      ProfileMenuItem(
                        icon: Icons.language_rounded,
                        title: 'اللغة',
                        trailing: Text(
                          'العربية',
                          style: GoogleFonts.tajawal(
                            fontSize: ResponsiveHelper.fontSize(13),
                            color: Colors.grey.shade600,
                          ),
                        ),
                        onTap: () {
                          _showLanguageDialog(context);
                        },
                      ),
                    ]),

                    SizedBox(height: ResponsiveHelper.height(24)),

                    // Support Section
                    const ProfileSectionHeader(title: 'الدعم والمساعدة'),
                    SizedBox(height: ResponsiveHelper.height(12)),
                    _buildMenuCard(context, [
                      ProfileMenuItem(
                        icon: Icons.help_rounded,
                        title: 'المساعدة والدعم',
                        onTap: () => context.push('/${RouteNames.helpSupport}'),
                      ),
                      ProfileMenuItem(
                        icon: Icons.privacy_tip_rounded,
                        title: 'سياسة الخصوصية',
                        onTap: () =>
                            context.push('/${RouteNames.privacyPolicy}'),
                      ),
                      ProfileMenuItem(
                        icon: Icons.description_rounded,
                        title: 'الشروط والأحكام',
                        onTap: () =>
                            context.push('/${RouteNames.termsOfService}'),
                      ),
                      ProfileMenuItem(
                        icon: Icons.info_rounded,
                        title: 'عن التطبيق',
                        onTap: () => context.push('/${RouteNames.aboutUs}'),
                      ),
                    ]),

                    SizedBox(height: ResponsiveHelper.height(24)),

                    // Logout Button
                    _buildLogoutButton(context),

                    SizedBox(height: ResponsiveHelper.height(40)),

                    // App Version
                    Center(
                      child: Text(
                        'الإصدار 1.0.0',
                        style: GoogleFonts.tajawal(
                          fontSize: ResponsiveHelper.fontSize(12),
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),

                    SizedBox(height: ResponsiveHelper.height(20)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ NEW: Helper method to create badge widget
  Widget _buildBadge(String count) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.width(8),
        vertical: ResponsiveHelper.height(4),
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(10)),
      ),
      child: Text(
        count,
        style: GoogleFonts.cairo(
          fontSize: ResponsiveHelper.fontSize(12),
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, List<ProfileMenuItem> items) {
    return Container(
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
        children: List.generate(
          items.length,
          (index) => Column(
            children: [
              items[index],
              if (index < items.length - 1)
                Divider(
                  height: 1,
                  indent: ResponsiveHelper.width(60),
                  endIndent: ResponsiveHelper.width(16),
                  color: Colors.grey.shade200,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return InkWell(
      onTap: () {
        _showLogoutDialog(context);
      },
      borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.height(14)),
        decoration: BoxDecoration(
          color: AppColors.error.withOpacity(0.1),
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
          border: Border.all(color: AppColors.error.withOpacity(0.3), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.logout_rounded,
              color: AppColors.error,
              size: ResponsiveHelper.width(22),
            ),
            SizedBox(width: ResponsiveHelper.width(12)),
            Text(
              'تسجيل الخروج',
              style: GoogleFonts.cairo(
                fontSize: ResponsiveHelper.fontSize(16),
                fontWeight: FontWeight.bold,
                color: AppColors.error,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
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
                Icons.logout_rounded,
                color: AppColors.error,
                size: ResponsiveHelper.width(24),
              ),
              SizedBox(width: ResponsiveHelper.width(12)),
              Text(
                'تسجيل الخروج',
                style: GoogleFonts.cairo(
                  fontSize: ResponsiveHelper.fontSize(18),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            'هل أنت متأكد من تسجيل الخروج من حسابك؟',
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
                context.go('/${RouteNames.welcome}');
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
                'تسجيل الخروج',
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

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
          ),
          title: Text(
            'اختر اللغة',
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(18),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageOption(context, 'العربية', true),
              SizedBox(height: ResponsiveHelper.height(12)),
              _buildLanguageOption(context, 'English', false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    String language,
    bool isSelected,
  ) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                'سيتم تغيير اللغة قريباً',
                style: GoogleFonts.tajawal(color: Colors.white),
              ),
            ),
            backgroundColor: AppColors.info,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
      child: Container(
        padding: EdgeInsets.all(ResponsiveHelper.width(16)),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.1)
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_unchecked_rounded,
              color: isSelected ? AppColors.primary : Colors.grey.shade400,
            ),
            SizedBox(width: ResponsiveHelper.width(12)),
            Text(
              language,
              style: GoogleFonts.cairo(
                fontSize: ResponsiveHelper.fontSize(15),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? AppColors.primary : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
