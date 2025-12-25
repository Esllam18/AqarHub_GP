import 'package:aqar_hub_gp/core/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/consts/home_strings.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:go_router/go_router.dart';
import '../widgets/smart_search_bar.dart';
import '../widgets/category_filter_list.dart';
import '../widgets/apartment_list_item.dart';

class UserHomeView extends StatelessWidget {
  const UserHomeView({super.key});

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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: CustomScrollView(
          slivers: [
            // Floating App Bar - Appears when scrolling
            SliverAppBar(
              expandedHeight: ResponsiveHelper.responsive(
                context: context,
                mobile: 110,
                tablet: 120,
              ),
              floating: true, // ✅ Changed: App bar floats when scrolling up
              snap: true, // ✅ Added: Snaps into view completely
              pinned: false, // ✅ Changed: Not always pinned, only when expanded
              backgroundColor: AppColors.primary,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.primary, AppColors.secondary],
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
                              // Welcome Section
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _getGreeting(),
                                      style: GoogleFonts.tajawal(
                                        fontSize: ResponsiveHelper.fontSize(13),
                                        color: AppColors.white.withOpacity(
                                          0.85,
                                        ),
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.3,
                                      ),
                                      textDirection: TextDirection.rtl,
                                    ),
                                    SizedBox(
                                      height: ResponsiveHelper.height(4),
                                    ),
                                    Text(
                                      HomeStrings.welcomeMessage,
                                      style: GoogleFonts.cairo(
                                        fontSize: ResponsiveHelper.fontSize(18),
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold,
                                        height: 1.2,
                                      ),
                                      textDirection: TextDirection.rtl,
                                    ),
                                    SizedBox(
                                      height: ResponsiveHelper.height(4),
                                    ),
                                    Text(
                                      HomeStrings.chooseProperty,
                                      style: GoogleFonts.tajawal(
                                        fontSize: ResponsiveHelper.fontSize(12),
                                        color: AppColors.white.withOpacity(0.8),
                                        fontWeight: FontWeight.w400,
                                      ),
                                      textDirection: TextDirection.rtl,
                                    ),
                                  ],
                                ),
                              ),
                              // Notification Bell
                              Row(
                                textDirection: TextDirection.ltr,
                                children: [
                                  SizedBox(width: ResponsiveHelper.width(10)),
                                  Container(
                                    width: ResponsiveHelper.width(42),
                                    height: ResponsiveHelper.width(42),
                                    decoration: BoxDecoration(
                                      color: AppColors.white.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(
                                        ResponsiveHelper.radius(12),
                                      ),
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
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                centerTitle: false,
                titlePadding: EdgeInsets.only(
                  right: ResponsiveHelper.width(20),
                  bottom: ResponsiveHelper.height(14),
                ),
              ),
            ),

            // Search Bar Section
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  ResponsiveHelper.width(16),
                  ResponsiveHelper.height(16),
                  ResponsiveHelper.width(16),
                  ResponsiveHelper.height(8),
                ),
                child: SmartSearchBar(
                  onTap: () {
                    context.push(RouteNames.smartSearch);
                  },
                ),
              ),
            ),

            // Category Filter
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveHelper.width(16),
                  vertical: ResponsiveHelper.height(8),
                ),
                child: const CategoryFilterList(),
              ),
            ),

            // Section Header
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  ResponsiveHelper.width(16),
                  ResponsiveHelper.height(16),
                  ResponsiveHelper.width(16),
                  ResponsiveHelper.height(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textDirection: TextDirection.rtl,
                  children: [
                    Text(
                      HomeStrings.featured,
                      style: GoogleFonts.cairo(
                        fontSize: ResponsiveHelper.fontSize(17),
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveHelper.width(8),
                        ),
                      ),
                      child: Row(
                        textDirection: TextDirection.rtl,
                        children: [
                          Text(
                            HomeStrings.seeAll,
                            style: GoogleFonts.tajawal(
                              fontSize: ResponsiveHelper.fontSize(14),
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                          SizedBox(width: ResponsiveHelper.width(4)),
                          Icon(
                            Icons.arrow_back_ios_rounded,
                            size: ResponsiveHelper.width(12),
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Apartment List
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.width(16),
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return ApartmentListItem(
                    onTap: () {
                      context.push(RouteNames.apartmentDetails);
                    },
                  );
                }, childCount: 10),
              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: ResponsiveHelper.height(100)),
            ),
          ],
        ),
      ),
    );
  }
}
