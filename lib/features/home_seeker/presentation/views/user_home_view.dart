import 'package:aqar_hub_gp/core/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:go_router/go_router.dart';
import '../../data/apartments_list.dart';
import '../widgets/user_home/smart_search_bar.dart';
import '../widgets/user_home/category_filter_list.dart';
import '../widgets/shared/apartment_list_item.dart';
import '../widgets/user_home/home_sliver_app_bar.dart';
import '../widgets/user_home/home_section_header.dart';

class UserHomeView extends StatelessWidget {
  const UserHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: null,
        backgroundColor: AppColors.background,
        body: CustomScrollView(
          slivers: [
            HomeSliverAppBar(
              onNotificationPressed: () {
                context.push('/${RouteNames.notifications}');
              },
            ),
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
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveHelper.width(16),
                  vertical: ResponsiveHelper.height(8),
                ),
                child: const CategoryFilterList(),
              ),
            ),
            SliverToBoxAdapter(
              child: HomeSectionHeader(onSeeAllPressed: () {}),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.width(16),
              ),
              sliver: SliverList.builder(
                itemCount: apartments.length,
                itemBuilder: (context, index) {
                  final apartment = apartments[index];
                  return ApartmentListItem(
                    title: apartment['title'],
                    location: apartment['location'],
                    price: apartment['price'],
                    imageUrl: apartment['imageUrl'],
                    bedrooms: apartment['bedrooms'],
                    bathrooms: apartment['bathrooms'],
                    area: apartment['area'],
                    rating: apartment['rating'],
                    reviewCount: apartment['reviewCount'],
                    isFeatured: apartment['isFeatured'] ?? false,
                    isVerified: apartment['isVerified'] ?? false,
                    badge: apartment['badge'],
                    onTap: () {
                      context.push(
                        RouteNames.apartmentDetails,
                        extra: {'apartment': apartment},
                      );
                    },
                  );
                },
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
