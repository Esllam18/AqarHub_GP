import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class AcceptedCardsSection extends StatelessWidget {
  const AcceptedCardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'البطاقات المقبولة',
          style: GoogleFonts.cairo(
            fontSize: ResponsiveHelper.fontSize(14),
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: ResponsiveHelper.height(12)),
        Row(
          children: [
            _buildCardLogo('💳 Visa'),
            SizedBox(width: ResponsiveHelper.width(12)),
            _buildCardLogo('💳 Mastercard'),
            SizedBox(width: ResponsiveHelper.width(12)),
            _buildCardLogo('💳 Meeza'),
          ],
        ),
      ],
    );
  }

  Widget _buildCardLogo(String text) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.width(12),
        vertical: ResponsiveHelper.height(6),
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(8)),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        text,
        style: GoogleFonts.cairo(
          fontSize: ResponsiveHelper.fontSize(12),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
