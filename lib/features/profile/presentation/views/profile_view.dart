import 'package:flutter/material.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:aqar_hub_gp/core/router/route_names.dart';
import 'package:go_router/go_router.dart';
import '../widgets/profile_section_header.dart';
import '../widgets/profile_menu_item.dart';
import '../widgets/profile_header/profile_app_bar.dart';
import '../widgets/profile_header/profile_menu_card.dart';
import '../widgets/profile_dialogs/logout_dialog.dart';
import '../widgets/profile_dialogs/language_dialog.dart';

class ProfileView extends StatelessWidget {
  final bool isOwner;

  const ProfileView({super.key, this.isOwner = false});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: CustomScrollView(
          slivers: [
            ProfileAppBar(isOwner: isOwner),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(ResponsiveHelper.width(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: ResponsiveHelper.height(8)),
                    _buildAccountSection(context),
                    SizedBox(height: ResponsiveHelper.height(24)),
                    _buildSettingsSection(context),
                    SizedBox(height: ResponsiveHelper.height(24)),
                    _buildSupportSection(context),
                    SizedBox(height: ResponsiveHelper.height(24)),
                    _buildLogoutButton(context),
                    SizedBox(height: ResponsiveHelper.height(40)),
                    _buildAppVersion(),
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

  Widget _buildAccountSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProfileSectionHeader(title: 'الحساب'),
        SizedBox(height: ResponsiveHelper.height(12)),
        ProfileMenuCard(
          items: [
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
                onTap: () => context.push('/${RouteNames.myProperties}'),
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
              onTap: () => context.push('/${RouteNames.paymentHistory}'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProfileSectionHeader(title: 'الإعدادات'),
        SizedBox(height: ResponsiveHelper.height(12)),
        ProfileMenuCard(
          items: [
            ProfileMenuItem(
              icon: Icons.settings_rounded,
              title: 'الإعدادات',
              onTap: () => context.push('/${RouteNames.settings}'),
            ),
            ProfileMenuItem(
              icon: Icons.notifications_rounded,
              title: 'الإشعارات',
              trailing: _buildBadge('3'),
              onTap: () => context.push('/${RouteNames.notifications}'),
            ),
            ProfileMenuItem(
              icon: Icons.language_rounded,
              title: 'اللغة',
              trailing: _buildLanguageTrailing(),
              onTap: () => showLanguageDialog(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSupportSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProfileSectionHeader(title: 'الدعم والمساعدة'),
        SizedBox(height: ResponsiveHelper.height(12)),
        ProfileMenuCard(
          items: [
            ProfileMenuItem(
              icon: Icons.help_rounded,
              title: 'المساعدة والدعم',
              onTap: () => context.push('/${RouteNames.helpSupport}'),
            ),
            ProfileMenuItem(
              icon: Icons.privacy_tip_rounded,
              title: 'سياسة الخصوصية',
              onTap: () => context.push('/${RouteNames.privacyPolicy}'),
            ),
            ProfileMenuItem(
              icon: Icons.description_rounded,
              title: 'الشروط والأحكام',
              onTap: () => context.push('/${RouteNames.termsOfService}'),
            ),
            ProfileMenuItem(
              icon: Icons.info_rounded,
              title: 'عن التطبيق',
              onTap: () => context.push('/${RouteNames.aboutUs}'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return InkWell(
      onTap: () => showLogoutDialog(context),
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
              style: TextStyle(
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
        style: TextStyle(
          fontSize: ResponsiveHelper.fontSize(12),
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildLanguageTrailing() {
    return Text(
      'العربية',
      style: TextStyle(
        fontSize: ResponsiveHelper.fontSize(13),
        color: Colors.grey.shade600,
      ),
    );
  }

  Widget _buildAppVersion() {
    return Center(
      child: Text(
        'الإصدار 1.0.0',
        style: TextStyle(
          fontSize: ResponsiveHelper.fontSize(12),
          color: Colors.grey.shade500,
        ),
      ),
    );
  }
}
