import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/consts/home_strings.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class CategoryFilterList extends StatefulWidget {
  const CategoryFilterList({super.key});

  @override
  State<CategoryFilterList> createState() => _CategoryFilterListState();
}

class _CategoryFilterListState extends State<CategoryFilterList> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _categories = [
    {'name': HomeStrings.allCategories, 'icon': Icons.apps_rounded},
    {'name': HomeStrings.apartment, 'icon': Icons.apartment_rounded},

    {'name': HomeStrings.studio, 'icon': Icons.meeting_room_rounded},
    {'name': HomeStrings.villa, 'icon': Icons.house_rounded},
    {'name': HomeStrings.office, 'icon': Icons.business_center_rounded},
    {'name': HomeStrings.family, 'icon': Icons.family_restroom_rounded},

    {'name': HomeStrings.shared, 'icon': Icons.people_alt_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // RTL: Scroll from right to left
      child: SizedBox(
        height: ResponsiveHelper.height(90),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _categories.length,
          padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.height(8)),
          reverse: false, // Start from right in RTL
          itemBuilder: (context, index) {
            final isSelected = _selectedIndex == index;
            final category = _categories[index];

            return Padding(
              padding: EdgeInsets.only(
                left: ResponsiveHelper.width(10),
              ), // Changed to left for RTL
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveHelper.width(16),
                    vertical: ResponsiveHelper.height(10),
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : AppColors.white,
                    borderRadius: BorderRadius.circular(
                      ResponsiveHelper.radius(14),
                    ),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : Colors.grey.shade300,
                      width: 1.5,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.3),
                              blurRadius: ResponsiveHelper.height(8),
                              offset: Offset(0, ResponsiveHelper.height(3)),
                            ),
                          ]
                        : [],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon
                      Icon(
                        category['icon'],
                        size: ResponsiveHelper.width(24),
                        color: isSelected ? AppColors.white : AppColors.primary,
                      ),
                      SizedBox(height: ResponsiveHelper.height(6)),
                      // Text with RTL
                      Text(
                        category['name'],
                        style: GoogleFonts.tajawal(
                          fontSize: ResponsiveHelper.fontSize(12),
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w500,
                          color: isSelected
                              ? AppColors.white
                              : Colors.grey.shade700,
                        ),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
