import 'package:flutter/material.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'profile_avatar.dart';
import 'profile_user_info.dart';

class ProfileAppBar extends StatelessWidget {
  final bool isOwner;

  const ProfileAppBar({super.key, required this.isOwner});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: ResponsiveHelper.height(200),
      floating: false,
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.primary,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: ResponsiveHelper.height(20)),
                const ProfileAvatar(
                  imageUrl: 'https://i.pravatar.cc/150?img=12',
                ),
                SizedBox(height: ResponsiveHelper.height(12)),
                ProfileUserInfo(isOwner: isOwner),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
