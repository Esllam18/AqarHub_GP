import 'package:flutter/material.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'apartment_image_section.dart';
import 'apartment_details_section.dart';

class ApartmentListItem extends StatefulWidget {
  final VoidCallback onTap;
  final String title;
  final String location;
  final int price;
  final String imageUrl;
  final int bedrooms;
  final int bathrooms;
  final int area;
  final double rating;
  final int reviewCount;
  final bool isVerified;
  final bool isFeatured;
  final String? badge;

  const ApartmentListItem({
    super.key,
    required this.onTap,
    required this.title,
    required this.location,
    required this.price,
    required this.imageUrl,
    this.bedrooms = 2,
    this.bathrooms = 1,
    this.area = 80,
    this.rating = 4.8,
    this.reviewCount = 125,
    this.isVerified = true,
    this.isFeatured = false,
    this.badge,
  });

  @override
  State<ApartmentListItem> createState() => _ApartmentListItemState();
}

class _ApartmentListItemState extends State<ApartmentListItem> {
  bool _isFavorite = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: EdgeInsets.only(bottom: ResponsiveHelper.height(12)),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.06),
                blurRadius: ResponsiveHelper.height(15),
                offset: Offset(0, ResponsiveHelper.height(4)),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ApartmentImageSection(
                imageUrl: widget.imageUrl,
                isVerified: widget.isVerified,
                isFeatured: widget.isFeatured,
                badge: widget.badge,
                isFavorite: _isFavorite,
                onFavoriteToggle: _toggleFavorite,
              ),
              ApartmentDetailsSection(
                title: widget.title,
                location: widget.location,
                price: widget.price,
                bedrooms: widget.bedrooms,
                bathrooms: widget.bathrooms,
                area: widget.area,
                rating: widget.rating,
                reviewCount: widget.reviewCount,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
