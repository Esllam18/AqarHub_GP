import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:go_router/go_router.dart';
import '../widgets/profile_menu_item.dart';
import '../widgets/profile_stat_card.dart';
import '../widgets/profile_section_header.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: CustomScrollView(
          slivers: [
            // Premium Curved Header
            SliverAppBar(
              expandedHeight: ResponsiveHelper.height(280),
              floating: false,
              pinned: true,
              backgroundColor: AppColors.primary,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                background: _buildProfileHeader(context),
              ),
            ),

            // Profile Content
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: ResponsiveHelper.height(20)),

                  // Stats Cards
                  _buildStatsSection(),

                  SizedBox(height: ResponsiveHelper.height(24)),

                  // Account Section
                  ProfileSectionHeader(title: 'الحساب'),
                  SizedBox(height: ResponsiveHelper.height(12)),
                  _buildAccountSection(),

                  SizedBox(height: ResponsiveHelper.height(24)),

                  // Settings Section
                  ProfileSectionHeader(title: 'الإعدادات'),
                  SizedBox(height: ResponsiveHelper.height(12)),
                  _buildSettingsSection(),

                  SizedBox(height: ResponsiveHelper.height(24)),

                  // Support Section
                  ProfileSectionHeader(title: 'الدعم والمساعدة'),
                  SizedBox(height: ResponsiveHelper.height(12)),
                  _buildSupportSection(),

                  SizedBox(height: ResponsiveHelper.height(32)),

                  // Logout Button
                  _buildLogoutButton(context),

                  SizedBox(height: ResponsiveHelper.height(40)),

                  // App Version
                  Text(
                    'الإصدار 1.0.0',
                    style: GoogleFonts.tajawal(
                      fontSize: ResponsiveHelper.fontSize(12),
                      color: Colors.grey.shade500,
                    ),
                    textDirection: TextDirection.rtl,
                  ),

                  SizedBox(height: ResponsiveHelper.height(20)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
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
          mainAxisSize: MainAxisSize.min, // ✅ Changed from max to min
          children: [
            SizedBox(height: ResponsiveHelper.height(30)), // ✅ Reduced from 40
            // Profile Image with Edit Button
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.white,
                      width: 3, // ✅ Reduced from 4
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 15, // ✅ Reduced from 20
                        offset: const Offset(0, 6), // ✅ Reduced from 8
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: ResponsiveHelper.width(45), // ✅ Reduced from 50
                    backgroundColor: AppColors.white,
                    backgroundImage: const NetworkImage(
                      'https://ui-avatars.com/api/?name=User+Name&background=1E88E5&color=fff&size=200',
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      // TODO: Change profile picture
                    },
                    child: Container(
                      width: ResponsiveHelper.width(32), // ✅ Reduced from 36
                      height: ResponsiveHelper.width(32),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.primary, AppColors.secondary],
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.white,
                          width: 2.5, // ✅ Reduced from 3
                        ),
                      ),
                      child: Icon(
                        Icons.camera_alt_rounded,
                        color: AppColors.white,
                        size: ResponsiveHelper.width(14), // ✅ Reduced from 16
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: ResponsiveHelper.height(12)), // ✅ Reduced from 16
            // User Name
            Text(
              'أحمد محمد',
              style: GoogleFonts.cairo(
                fontSize: ResponsiveHelper.fontSize(22), // ✅ Reduced from 24
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
              textDirection: TextDirection.rtl,
            ),

            SizedBox(height: ResponsiveHelper.height(4)), // ✅ Reduced from 6
            // Email
            Text(
              'ahmed.mohammed@email.com',
              style: GoogleFonts.tajawal(
                fontSize: ResponsiveHelper.fontSize(13), // ✅ Reduced from 14
                color: AppColors.white.withOpacity(0.9),
              ),
            ),

            SizedBox(height: ResponsiveHelper.height(12)), // ✅ Reduced from 16
            // Edit Profile Button
            GestureDetector(
              onTap: () {
                // TODO: Navigate to edit profile
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveHelper.width(20), // ✅ Reduced from 24
                  vertical: ResponsiveHelper.height(8), // ✅ Reduced from 10
                ),
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(
                    ResponsiveHelper.radius(20),
                  ),
                  border: Border.all(
                    color: AppColors.white.withOpacity(0.3),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.edit_rounded,
                      color: AppColors.white,
                      size: ResponsiveHelper.width(14), // ✅ Reduced from 16
                    ),
                    SizedBox(width: ResponsiveHelper.width(6)),
                    Text(
                      'تعديل الملف الشخصي',
                      style: GoogleFonts.tajawal(
                        fontSize: ResponsiveHelper.fontSize(
                          12,
                        ), // ✅ Reduced from 13
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: ResponsiveHelper.height(20),
            ), // ✅ Added bottom padding
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.width(16)),
      child: Row(
        children: [
          Expanded(
            child: ProfileStatCard(
              icon: Icons.favorite_rounded,
              value: '24',
              label: 'المفضلة',
              color: AppColors.error,
              onTap: () {
                // TODO: Navigate to favorites
              },
            ),
          ),
          SizedBox(width: ResponsiveHelper.width(12)),
          Expanded(
            child: ProfileStatCard(
              icon: Icons.visibility_rounded,
              value: '156',
              label: 'المشاهدات',
              color: AppColors.primary,
              onTap: () {},
            ),
          ),
          SizedBox(width: ResponsiveHelper.width(12)),
          Expanded(
            child: ProfileStatCard(
              icon: Icons.apartment_rounded,
              value: '8',
              label: 'عقاراتي',
              color: AppColors.success,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ResponsiveHelper.width(16)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          ProfileMenuItem(
            icon: Icons.person_outline_rounded,
            title: 'المعلومات الشخصية',
            subtitle: 'قم بتحديث معلوماتك',
            onTap: () {},
          ),
          Divider(
            height: 1,
            indent: ResponsiveHelper.width(60),
            color: Colors.grey.shade200,
          ),
          ProfileMenuItem(
            icon: Icons.security_rounded,
            title: 'الأمان',
            subtitle: 'كلمة المرور والحماية',
            onTap: () {},
          ),
          Divider(
            height: 1,
            indent: ResponsiveHelper.width(60),
            color: Colors.grey.shade200,
          ),
          ProfileMenuItem(
            icon: Icons.verified_user_rounded,
            title: 'التحقق من الحساب',
            subtitle: 'وثق حسابك الآن',
            trailing: Container(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.width(8),
                vertical: ResponsiveHelper.height(4),
              ),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(ResponsiveHelper.radius(6)),
              ),
              child: Text(
                'موثق',
                style: GoogleFonts.tajawal(
                  fontSize: ResponsiveHelper.fontSize(10),
                  color: AppColors.success,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ResponsiveHelper.width(16)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          ProfileMenuItem(
            icon: Icons.notifications_outlined,
            title: 'الإشعارات',
            subtitle: 'إدارة التنبيهات',
            trailing: Switch(
              value: true,
              onChanged: (value) {},
              activeColor: AppColors.primary,
            ),
            onTap: () {},
          ),
          Divider(
            height: 1,
            indent: ResponsiveHelper.width(60),
            color: Colors.grey.shade200,
          ),
          ProfileMenuItem(
            icon: Icons.language_rounded,
            title: 'اللغة',
            subtitle: 'العربية',
            onTap: () {},
          ),
          Divider(
            height: 1,
            indent: ResponsiveHelper.width(60),
            color: Colors.grey.shade200,
          ),
          ProfileMenuItem(
            icon: Icons.dark_mode_outlined,
            title: 'المظهر',
            subtitle: 'فاتح / داكن',
            trailing: Switch(
              value: false,
              onChanged: (value) {},
              activeColor: AppColors.primary,
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSupportSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ResponsiveHelper.width(16)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          ProfileMenuItem(
            icon: Icons.help_outline_rounded,
            title: 'مركز المساعدة',
            subtitle: 'الأسئلة الشائعة والدعم',
            onTap: () {},
          ),
          Divider(
            height: 1,
            indent: ResponsiveHelper.width(60),
            color: Colors.grey.shade200,
          ),
          ProfileMenuItem(
            icon: Icons.privacy_tip_outlined,
            title: 'الخصوصية والشروط',
            subtitle: 'سياسة الخصوصية',
            onTap: () {},
          ),
          Divider(
            height: 1,
            indent: ResponsiveHelper.width(60),
            color: Colors.grey.shade200,
          ),
          ProfileMenuItem(
            icon: Icons.info_outline_rounded,
            title: 'حول التطبيق',
            subtitle: 'معلومات عن عقار هب',
            onTap: () {},
          ),
          Divider(
            height: 1,
            indent: ResponsiveHelper.width(60),
            color: Colors.grey.shade200,
          ),
          ProfileMenuItem(
            icon: Icons.star_outline_rounded,
            title: 'قيم التطبيق',
            subtitle: 'شارك رأيك معنا',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.width(16)),
      child: GestureDetector(
        onTap: () {
          _showLogoutDialog(context);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.height(16)),
          decoration: BoxDecoration(
            color: AppColors.error.withOpacity(0.1),
            borderRadius: BorderRadius.circular(ResponsiveHelper.radius(14)),
            border: Border.all(
              color: AppColors.error.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.logout_rounded,
                color: AppColors.error,
                size: ResponsiveHelper.width(20),
              ),
              SizedBox(width: ResponsiveHelper.width(10)),
              Text(
                'تسجيل الخروج',
                style: GoogleFonts.cairo(
                  fontSize: ResponsiveHelper.fontSize(15),
                  color: AppColors.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
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
            borderRadius: BorderRadius.circular(ResponsiveHelper.radius(20)),
          ),
          title: Row(
            textDirection: TextDirection.rtl,
            children: [
              Icon(
                Icons.logout_rounded,
                color: AppColors.error,
                size: ResponsiveHelper.width(24),
              ),
              SizedBox(width: ResponsiveHelper.width(10)),
              Text(
                'تسجيل الخروج',
                style: GoogleFonts.cairo(
                  fontSize: ResponsiveHelper.fontSize(18),
                  fontWeight: FontWeight.bold,
                ),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
          content: Text(
            'هل أنت متأكد من رغبتك في تسجيل الخروج؟',
            style: GoogleFonts.tajawal(
              fontSize: ResponsiveHelper.fontSize(14),
              color: Colors.grey.shade700,
            ),
            textDirection: TextDirection.rtl,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'إلغاء',
                style: GoogleFonts.tajawal(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                context.go('/welcome');
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
                style: GoogleFonts.tajawal(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
