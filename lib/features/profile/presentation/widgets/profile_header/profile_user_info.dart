import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class ProfileUserInfo extends StatelessWidget {
  final bool isOwner;

  const ProfileUserInfo({super.key, required this.isOwner});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'أحمد محمد علي',
          style: GoogleFonts.cairo(
            fontSize: ResponsiveHelper.fontSize(20),
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: ResponsiveHelper.height(4)),
        _buildRoleBadge(),
      ],
    );
  }

  Widget _buildRoleBadge() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.width(12),
        vertical: ResponsiveHelper.height(6),
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(20)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isOwner ? Icons.business_rounded : Icons.person_rounded,
            color: Colors.white,
            size: ResponsiveHelper.width(16),
          ),
          SizedBox(width: ResponsiveHelper.width(6)),
          Text(
            isOwner ? 'مالك عقار' : 'باحث عن سكن',
            style: GoogleFonts.tajawal(
              fontSize: ResponsiveHelper.fontSize(13),
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
