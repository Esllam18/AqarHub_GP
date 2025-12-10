import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/enums/user_role.dart';
import 'package:aqar_hub_gp/core/router/route_names.dart';
import 'package:aqar_hub_gp/core/services/navigation_service.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:aqar_hub_gp/features/authentication/domain/entities/user_entity.dart';
import 'package:aqar_hub_gp/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatelessWidget {
  final UserEntity? user;

  const HomeView({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          'عقار هب',
          style: GoogleFonts.cairo(
            fontSize: ResponsiveHelper.fontSize(24),
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.primary),
            onPressed: () {
              context.read<AuthCubit>().signOut();
              NavigationService.navigateToAndReplace(
                context,
                RouteNames.welcome,
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(ResponsiveHelper.width(24)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: ResponsiveHelper.height(20)),
              _buildWelcomeSection(),
              SizedBox(height: ResponsiveHelper.height(40)),
              _buildRoleSpecificContent(),
              const Spacer(),
              _buildPlaceholderSection(),
              SizedBox(height: ResponsiveHelper.height(24)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    final name = user?.firstName ?? 'المستخدم';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'قريباً، $name!',
          style: GoogleFonts.cairo(
            fontSize: ResponsiveHelper.fontSize(28),
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: ResponsiveHelper.height(8)),
        Text(
          user?.role == UserRole.owner
              ? 'قريباً بك كمالك عقار'
              : 'قريباً بك كمستخدم',
          style: GoogleFonts.tajawal(
            fontSize: ResponsiveHelper.fontSize(16),
            // ignore: deprecated_member_use
            color: AppColors.primary.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildRoleSpecificContent() {
    if (user?.role == UserRole.owner) {
      return _buildOwnerContent();
    } else {
      return _buildUserContent();
    }
  }

  Widget _buildUserContent() {
    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.width(20)),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.search,
                color: AppColors.primary,
                size: ResponsiveHelper.width(24),
              ),
              SizedBox(width: ResponsiveHelper.width(12)),
              Text(
                'ابحث عن عقارك المثالي',
                style: GoogleFonts.cairo(
                  fontSize: ResponsiveHelper.fontSize(18),
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: ResponsiveHelper.height(12)),
          Text(
            'قريباً: تصفح العقارات المتاحة في منطقتك',
            style: GoogleFonts.tajawal(
              fontSize: ResponsiveHelper.fontSize(14),
              // ignore: deprecated_member_use
              color: AppColors.primary.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOwnerContent() {
    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.width(20)),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.business,
                color: AppColors.primary,
                size: ResponsiveHelper.width(24),
              ),
              SizedBox(width: ResponsiveHelper.width(12)),
              Text(
                'إدارة عقاراتك',
                style: GoogleFonts.cairo(
                  fontSize: ResponsiveHelper.fontSize(18),
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: ResponsiveHelper.height(12)),
          Text(
            'قريباً: قم بإضافة إدارة عقاراتك بسهولة',
            style: GoogleFonts.tajawal(
              fontSize: ResponsiveHelper.fontSize(14),
              // ignore: deprecated_member_use
              color: AppColors.primary.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderSection() {
    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.width(20)),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.chat_bubble_outline,
            color: AppColors.primary,
            size: ResponsiveHelper.width(32),
          ),
          SizedBox(width: ResponsiveHelper.width(16)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'خدمة الدردشة',
                  style: GoogleFonts.cairo(
                    fontSize: ResponsiveHelper.fontSize(16),
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  'قادمة قريباً',
                  style: GoogleFonts.tajawal(
                    fontSize: ResponsiveHelper.fontSize(14),
                    // ignore: deprecated_member_use
                    color: AppColors.primary.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
