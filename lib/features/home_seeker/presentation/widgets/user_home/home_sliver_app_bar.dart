import 'package:flutter/material.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/consts/home_strings.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'home_welcome_section.dart';

class HomeSliverAppBar extends StatelessWidget {
  final VoidCallback onNotificationPressed;

  const HomeSliverAppBar({super.key, required this.onNotificationPressed});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return HomeStrings.goodMorning;
    } else {
      return HomeStrings.goodEvening;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: ResponsiveHelper.responsive(
        context: context,
        mobile: 110,
        tablet: 120,
      ),
      floating: true,
      snap: true,
      pinned: false,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primary, AppColors.secondary],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(ResponsiveHelper.radius(20)),
              bottomRight: Radius.circular(ResponsiveHelper.radius(20)),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.width(20),
                vertical: ResponsiveHelper.height(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    textDirection: TextDirection.rtl,
                    children: [
                      Expanded(
                        child: HomeWelcomeSection(greeting: _getGreeting()),
                      ),
                      _buildNotificationButton(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      centerTitle: false,
    );
  }

  Widget _buildNotificationButton() {
    return Row(
      textDirection: TextDirection.ltr,
      children: [
        SizedBox(width: ResponsiveHelper.width(10)),
        Container(
          width: ResponsiveHelper.width(42),
          height: ResponsiveHelper.width(42),
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
            border: Border.all(
              color: AppColors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.notifications_outlined,
              color: AppColors.white,
              size: ResponsiveHelper.width(22),
            ),
            onPressed: onNotificationPressed,
          ),
        ),
      ],
    );
  }
}
