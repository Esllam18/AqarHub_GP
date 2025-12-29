import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/consts/home_strings.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:aqar_hub_gp/core/router/route_names.dart';
import 'apartment_list_item.dart';

class SearchApartmentResults extends StatelessWidget {
  final List<Map<String, dynamic>> searchResults;

  const SearchApartmentResults({super.key, required this.searchResults});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_buildResultsHeader(), _buildApartmentsList(context)],
    );
  }

  Widget _buildResultsHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.height(16)),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Container(
            padding: EdgeInsets.all(ResponsiveHelper.width(8)),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.1),
              borderRadius: BorderRadius.circular(ResponsiveHelper.radius(8)),
            ),
            child: Icon(
              Icons.check_circle_rounded,
              color: AppColors.success,
              size: ResponsiveHelper.width(20),
            ),
          ),
          SizedBox(width: ResponsiveHelper.width(10)),
          Text(
            HomeStrings.searchResults,
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(17),
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }

  Widget _buildApartmentsList(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final apartment = searchResults[index];
        return ApartmentListItem(
          onTap: () {
            context.push('/${RouteNames.apartmentDetails}');
          },
          title: apartment['title'] as String,
          location: apartment['location'] as String,
          price: apartment['price'] as int,
          imageUrl: apartment['imageUrl'] as String,
          bedrooms: apartment['bedrooms'] as int,
          bathrooms: apartment['bathrooms'] as int,
          area: apartment['area'] as int,
          rating: apartment['rating'] as double,
          reviewCount: apartment['reviewCount'] as int,
          isVerified: apartment['isVerified'] as bool? ?? false,
          isFeatured: apartment['isFeatured'] as bool? ?? false,
          badge: apartment['badge'] as String?,
        );
      },
    );
  }
}
