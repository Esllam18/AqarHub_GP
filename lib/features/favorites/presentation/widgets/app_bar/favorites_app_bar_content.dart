import 'package:aqar_hub_gp/features/favorites/models/favorite_apartment_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'header_action_button.dart';
import 'stats_row.dart';

class FavoritesAppBarContent extends StatelessWidget {
  final List<FavoriteApartmentModel> favorites;
  final VoidCallback onFilterTap;
  final VoidCallback onClearAllTap;

  const FavoritesAppBarContent({
    super.key,
    required this.favorites,
    required this.onFilterTap,
    required this.onClearAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ResponsiveHelper.width(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildHeader(),
          SizedBox(height: ResponsiveHelper.height(16)),
          StatsRow(favorites: favorites),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      textDirection: TextDirection.rtl,
      children: [_buildTitleSection(), _buildActionButtons()],
    );
  }

  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'مفضلتي',
          style: GoogleFonts.cairo(
            fontSize: ResponsiveHelper.fontSize(28),
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
          textDirection: TextDirection.rtl,
        ),
        SizedBox(height: ResponsiveHelper.height(4)),
        Text(
          '${favorites.length} عقار محفوظ',
          style: GoogleFonts.tajawal(
            fontSize: ResponsiveHelper.fontSize(14),
            color: AppColors.white.withOpacity(0.9),
          ),
          textDirection: TextDirection.rtl,
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        HeaderActionButton(icon: Icons.filter_list_rounded, onTap: onFilterTap),
        SizedBox(width: ResponsiveHelper.width(8)),
        HeaderActionButton(
          icon: Icons.delete_sweep_rounded,
          onTap: onClearAllTap,
        ),
      ],
    );
  }
}
