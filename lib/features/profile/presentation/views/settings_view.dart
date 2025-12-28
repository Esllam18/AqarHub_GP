import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

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
        appBar: AppBar(
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
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(ResponsiveHelper.width(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Notifications Section
              _buildSectionHeader('الإشعارات'),
              SizedBox(height: ResponsiveHelper.height(12)),
              _buildSettingsCard([
                _buildSwitchTile(
                  'إشعارات الدفع',
                  'تلقي إشعارات حول التطبيق',
                  Icons.notifications_rounded,
                  _pushNotifications,
                  (value) => setState(() => _pushNotifications = value),
                ),
                _buildDivider(),
                _buildSwitchTile(
                  'البريد الإلكتروني',
                  'تلقي رسائل عبر البريد',
                  Icons.email_rounded,
                  _emailNotifications,
                  (value) => setState(() => _emailNotifications = value),
                ),
                _buildDivider(),
                _buildSwitchTile(
                  'الرسائل النصية',
                  'تلقي رسائل SMS',
                  Icons.sms_rounded,
                  _smsNotifications,
                  (value) => setState(() => _smsNotifications = value),
                ),
              ]),

              SizedBox(height: ResponsiveHelper.height(24)),

              // Appearance Section
              _buildSectionHeader('المظهر'),
              SizedBox(height: ResponsiveHelper.height(12)),
              _buildSettingsCard([
                _buildSwitchTile(
                  'الوضع الليلي',
                  'تفعيل المظهر الداكن',
                  Icons.dark_mode_rounded,
                  _darkMode,
                  (value) {
                    setState(() => _darkMode = value);
                    _showComingSoonSnackbar(context);
                  },
                ),
              ]),

              SizedBox(height: ResponsiveHelper.height(24)),

              // Account Section
              _buildSectionHeader('الحساب'),
              SizedBox(height: ResponsiveHelper.height(12)),
              _buildSettingsCard([
                _buildActionTile(
                  'تغيير كلمة المرور',
                  'تحديث كلمة المرور الخاصة بك',
                  Icons.lock_rounded,
                  () => _showComingSoonSnackbar(context),
                ),
                _buildDivider(),
                _buildActionTile(
                  'إدارة الحساب',
                  'إعدادات الخصوصية والأمان',
                  Icons.security_rounded,
                  () => _showComingSoonSnackbar(context),
                ),
                _buildDivider(),
                _buildActionTile(
                  'حذف الحساب',
                  'حذف حسابك نهائياً',
                  Icons.delete_forever_rounded,
                  () => _showDeleteAccountDialog(context),
                  isDestructive: true,
                ),
              ]),

              SizedBox(height: ResponsiveHelper.height(24)),

              // Data & Storage
              _buildSectionHeader('البيانات والتخزين'),
              SizedBox(height: ResponsiveHelper.height(12)),
              _buildSettingsCard([
                _buildActionTile(
                  'مسح ذاكرة التخزين المؤقت',
                  'حرر مساحة التخزين',
                  Icons.cleaning_services_rounded,
                  () => _showClearCacheDialog(context),
                ),
                _buildDivider(),
                _buildActionTile(
                  'تحميل البيانات',
                  'تنزيل نسخة من بياناتك',
                  Icons.download_rounded,
                  () => _showComingSoonSnackbar(context),
                ),
              ]),

              SizedBox(height: ResponsiveHelper.height(40)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.cairo(
        fontSize: ResponsiveHelper.fontSize(16),
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
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
      child: Column(children: children),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    IconData icon,
    bool value,
    Function(bool) onChanged,
  ) {
    return Padding(
      padding: EdgeInsets.all(ResponsiveHelper.width(16)),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(ResponsiveHelper.width(10)),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(ResponsiveHelper.radius(10)),
            ),
            child: Icon(
              icon,
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
                  title,
                  style: GoogleFonts.cairo(
                    fontSize: ResponsiveHelper.fontSize(15),
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: ResponsiveHelper.height(4)),
                Text(
                  subtitle,
                  style: GoogleFonts.tajawal(
                    fontSize: ResponsiveHelper.fontSize(12),
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(ResponsiveHelper.width(16)),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(ResponsiveHelper.width(10)),
              decoration: BoxDecoration(
                color: (isDestructive ? AppColors.error : AppColors.primary)
                    .withOpacity(0.1),
                borderRadius: BorderRadius.circular(
                  ResponsiveHelper.radius(10),
                ),
              ),
              child: Icon(
                icon,
                color: isDestructive ? AppColors.error : AppColors.primary,
                size: ResponsiveHelper.width(24),
              ),
            ),
            SizedBox(width: ResponsiveHelper.width(12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.cairo(
                      fontSize: ResponsiveHelper.fontSize(15),
                      fontWeight: FontWeight.w600,
                      color: isDestructive ? AppColors.error : Colors.black87,
                    ),
                  ),
                  SizedBox(height: ResponsiveHelper.height(4)),
                  Text(
                    subtitle,
                    style: GoogleFonts.tajawal(
                      fontSize: ResponsiveHelper.fontSize(12),
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_back_ios_rounded,
              size: ResponsiveHelper.width(16),
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      indent: ResponsiveHelper.width(60),
      endIndent: ResponsiveHelper.width(16),
      color: Colors.grey.shade200,
    );
  }

  void _showComingSoonSnackbar(BuildContext context) {
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

  void _showDeleteAccountDialog(BuildContext context) {
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
                'حذف الحساب',
                style: GoogleFonts.cairo(
                  fontSize: ResponsiveHelper.fontSize(18),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            'هل أنت متأكد من حذف حسابك؟ سيتم حذف جميع بياناتك نهائياً ولا يمكن استرجاعها.',
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
                _showComingSoonSnackbar(context);
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
                'حذف الحساب',
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

  void _showClearCacheDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
          ),
          title: Text(
            'مسح ذاكرة التخزين المؤقت',
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(18),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'سيتم مسح الملفات المؤقتة لتحرير مساحة التخزين. هل تريد المتابعة؟',
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
                        'تم مسح ذاكرة التخزين المؤقت بنجاح',
                        style: GoogleFonts.tajawal(color: Colors.white),
                      ),
                    ),
                    backgroundColor: AppColors.success,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    ResponsiveHelper.radius(8),
                  ),
                ),
              ),
              child: Text(
                'مسح',
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
