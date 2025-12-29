import 'package:aqar_hub_gp/features/favorites/models/favorite_apartment_model.dart';
import 'package:flutter/material.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'stat_item.dart';

class StatsRow extends StatelessWidget {
  final List<FavoriteApartmentModel> favorites;

  const StatsRow({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        StatItem(
          icon: Icons.verified_rounded,
          label: 'موثقة',
          value: _getVerifiedCount(),
        ),
        SizedBox(width: ResponsiveHelper.width(20)),
        StatItem(
          icon: Icons.star_rounded,
          label: 'تقييم عالي',
          value: _getHighRatedCount(),
        ),
        SizedBox(width: ResponsiveHelper.width(20)),
        StatItem(
          icon: Icons.trending_up_rounded,
          label: 'هذا الأسبوع',
          value: _getThisWeekCount(),
        ),
      ],
    );
  }

  String _getVerifiedCount() {
    return favorites.where((apt) => apt.isVerified).length.toString();
  }

  String _getHighRatedCount() {
    return favorites.where((apt) => apt.rating >= 4.5).length.toString();
  }

  String _getThisWeekCount() {
    return favorites
        .where(
          (apt) => apt.addedDate.isAfter(
            DateTime.now().subtract(const Duration(days: 7)),
          ),
        )
        .length
        .toString();
  }
}
