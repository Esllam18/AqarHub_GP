import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class SearchQuickSuggestions extends StatelessWidget {
  final Function(String) onSuggestionTap;

  const SearchQuickSuggestions({super.key, required this.onSuggestionTap});

  @override
  Widget build(BuildContext context) {
    final suggestions = [
      {'icon': Icons.attach_money_rounded, 'text': 'شقة اقتصادية'},
      {'icon': Icons.family_restroom_rounded, 'text': 'شقة عائلية'},
      {'icon': Icons.weekend_rounded, 'text': 'شقة مفروشة'},
      {'icon': Icons.apartment_rounded, 'text': 'استوديو'},
    ];

    return Container(
      height: ResponsiveHelper.height(70),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.width(16),
          vertical: ResponsiveHelper.height(12),
        ),
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return Padding(
            padding: EdgeInsets.only(left: ResponsiveHelper.width(8)),
            child: InkWell(
              onTap: () => onSuggestionTap(suggestion['text'] as String),
              borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveHelper.width(16),
                  vertical: ResponsiveHelper.height(8),
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(
                    ResponsiveHelper.radius(12),
                  ),
                  border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    Icon(
                      suggestion['icon'] as IconData,
                      color: AppColors.primary,
                      size: ResponsiveHelper.width(18),
                    ),
                    SizedBox(width: ResponsiveHelper.width(8)),
                    Text(
                      suggestion['text'] as String,
                      style: GoogleFonts.cairo(
                        fontSize: ResponsiveHelper.fontSize(13),
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
