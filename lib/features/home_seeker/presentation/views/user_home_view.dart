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
  final List<Map<String, dynamic>> _apartments = const [
    {
      'title': 'شقة استوديو فاخرة مع إطلالة رائعة',
      'location': 'حي الزهور، بني سويف',
      'price': 3500,
      'imageUrl':
          'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800',
      'bedrooms': 2,
      'bathrooms': 1,
      'area': 80,
      'rating': 4.8,
      'reviewCount': 245,
      'isFeatured': true,
      'isVerified': true,
    },
    {
      'title': 'شقة عائلية واسعة في موقع هادئ',
      'location': 'بني سويف الجديدة',
      'price': 5200,
      'imageUrl':
          'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800',
      'bedrooms': 3,
      'bathrooms': 2,
      'area': 120,
      'rating': 4.9,
      'reviewCount': 189,
      'isVerified': true,
      'badge': 'جديد',
    },
    {
      'title': 'استوديو حديث بالقرب من الجامعة',
      'location': 'حي الرمد، بني سويف',
      'price': 2800,
      'imageUrl':
          'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=800',
      'bedrooms': 1,
      'bathrooms': 1,
      'area': 50,
      'rating': 4.6,
      'reviewCount': 128,
      'isVerified': true,
    },
    {
      'title': 'شقة مفروشة بالكامل - جاهزة للسكن',
      'location': 'بياض العرب، بني سويف',
      'price': 6500,
      'imageUrl':
          'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=800',
      'bedrooms': 2,
      'bathrooms': 2,
      'area': 95,
      'rating': 4.7,
      'reviewCount': 312,
      'isFeatured': true,
      'isVerified': true,
      'badge': 'عرض خاص',
    },
    {
      'title': 'شقة دوبلكس مع حديقة خاصة',
      'location': 'حي مقبل، بني سويف',
      'price': 7800,
      'imageUrl':
          'https://images.unsplash.com/photo-1494526585095-c41746248156?w=800',
      'bedrooms': 4,
      'bathrooms': 3,
      'area': 180,
      'rating': 4.9,
      'reviewCount': 98,
      'isVerified': true,
    },
    {
      'title': 'استوديو اقتصادي للأفراد',
      'location': 'الواسطى، بني سويف',
      'price': 2200,
      'imageUrl':
          'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=800',
      'bedrooms': 1,
      'bathrooms': 1,
      'area': 45,
      'rating': 4.3,
      'reviewCount': 75,
      'isVerified': true,
      'badge': 'أقل سعر',
    },
    {
      'title': 'شقة عصرية بموقع راقي',
      'location': 'حي الأباصيري، بني سويف',
      'price': 8500,
      'imageUrl':
          'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800',
      'bedrooms': 3,
      'bathrooms': 2,
      'area': 140,
      'rating': 4.8,
      'reviewCount': 156,
      'isFeatured': true,
      'isVerified': true,
    },
    {
      'title': 'شقة على النيل مباشرة',
      'location': 'ببا، بني سويف',
      'price': 9200,
      'imageUrl':
          'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=800',
      'bedrooms': 3,
      'bathrooms': 2,
      'area': 150,
      'rating': 5.0,
      'reviewCount': 203,
      'isVerified': true,
      'badge': 'إطلالة مميزة',
    },
  ];

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
        appBar: null,
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
                                      onPressed: () {
                                        // Navigate to notifications view
                                        context.push(
                                          '/${RouteNames.notifications}',
                                        );
                                      },
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
                  ResponsiveHelper.height(4),
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
                        fontSize: ResponsiveHelper.fontSize(15),
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
                              fontSize: ResponsiveHelper.fontSize(12),
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
              sliver: // Apartment List
              SliverList.builder(
                itemCount: _apartments.length,
                itemBuilder: (context, index) {
                  final apartment = _apartments[index];
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
                      // Navigate to apartment details
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
