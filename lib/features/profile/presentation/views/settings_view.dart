import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import '../widgets/settings_widgets/settings_section_header.dart';
import '../widgets/settings_widgets/settings_card.dart';
import '../widgets/settings_widgets/settings_switch_tile.dart';
import '../widgets/settings_widgets/settings_action_tile.dart';
import '../widgets/profile_dialogs/delete_account_dialog.dart';
import '../widgets/profile_dialogs/clear_cache_dialog.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool _pushNotifications = true;
  bool _emailNotifications = false;
  bool _smsNotifications = true;
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(ResponsiveHelper.width(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNotificationsSection(),
              SizedBox(height: ResponsiveHelper.height(24)),
              _buildAppearanceSection(),
              SizedBox(height: ResponsiveHelper.height(24)),
              _buildAccountSection(),
              SizedBox(height: ResponsiveHelper.height(24)),
              _buildDataSection(),
              SizedBox(height: ResponsiveHelper.height(40)),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_rounded, color: AppColors.primary),
        onPressed: () => context.pop(),
      ),
      title: Text(
        'الإعدادات',
        style: GoogleFonts.cairo(
          fontSize: ResponsiveHelper.fontSize(18),
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildNotificationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SettingsSectionHeader(title: 'الإشعارات'),
        SizedBox(height: ResponsiveHelper.height(12)),
        SettingsCard(
          children: [
            SettingsSwitchTile(
              title: 'إشعارات الدفع',
              subtitle: 'تلقي إشعارات حول التطبيق',
              icon: Icons.notifications_rounded,
              value: _pushNotifications,
              onChanged: (value) => setState(() => _pushNotifications = value),
            ),
            SettingsSwitchTile(
              title: 'البريد الإلكتروني',
              subtitle: 'تلقي رسائل عبر البريد',
              icon: Icons.email_rounded,
              value: _emailNotifications,
              onChanged: (value) => setState(() => _emailNotifications = value),
            ),
            SettingsSwitchTile(
              title: 'الرسائل النصية',
              subtitle: 'تلقي رسائل SMS',
              icon: Icons.sms_rounded,
              value: _smsNotifications,
              onChanged: (value) => setState(() => _smsNotifications = value),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAppearanceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SettingsSectionHeader(title: 'المظهر'),
        SizedBox(height: ResponsiveHelper.height(12)),
        SettingsCard(
          children: [
            SettingsSwitchTile(
              title: 'الوضع الليلي',
              subtitle: 'تفعيل المظهر الداكن',
              icon: Icons.dark_mode_rounded,
              value: _darkMode,
              onChanged: (value) {
                setState(() => _darkMode = value);
                _showComingSoonSnackbar();
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAccountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SettingsSectionHeader(title: 'الحساب'),
        SizedBox(height: ResponsiveHelper.height(12)),
        SettingsCard(
          children: [
            SettingsActionTile(
              title: 'تغيير كلمة المرور',
              subtitle: 'تحديث كلمة المرور الخاصة بك',
              icon: Icons.lock_rounded,
              onTap: _showComingSoonSnackbar,
            ),
            SettingsActionTile(
              title: 'إدارة الحساب',
              subtitle: 'إعدادات الخصوصية والأمان',
              icon: Icons.security_rounded,
              onTap: _showComingSoonSnackbar,
            ),
            SettingsActionTile(
              title: 'حذف الحساب',
              subtitle: 'حذف حسابك نهائياً',
              icon: Icons.delete_forever_rounded,
              onTap: () => showDeleteAccountDialog(context),
              isDestructive: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDataSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SettingsSectionHeader(title: 'البيانات والتخزين'),
        SizedBox(height: ResponsiveHelper.height(12)),
        SettingsCard(
          children: [
            SettingsActionTile(
              title: 'مسح ذاكرة التخزين المؤقت',
              subtitle: 'حرر مساحة التخزين',
              icon: Icons.cleaning_services_rounded,
              onTap: () => showClearCacheDialog(context),
            ),
            SettingsActionTile(
              title: 'تحميل البيانات',
              subtitle: 'تنزيل نسخة من بياناتك',
              icon: Icons.download_rounded,
              onTap: _showComingSoonSnackbar,
            ),
          ],
        ),
      ],
    );
  }

  void _showComingSoonSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            'سيتم إضافة هذه الميزة قريباً',
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
  }
}
